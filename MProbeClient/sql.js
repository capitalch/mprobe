let sql = {
    'tunnel:test':`
        select 1 from dummy
        select 2 from dummy;
        `,
    'tunnel:get:todays:sale': `SELECT "pos_name",   
         id="master_id" ,
			sale = (select sum(if type = 'S' then total_amt else -total_amt endif) from bill_memo
			where "date" = date(:mdate) and pos_id in(select pos_id from pointofsale where master_id = a.master_id)),
			gp = (select sum(gross_profit) from bill_memo_product key join bill_memo where "date" = date(:mdate) and pos_id in(select pos_id 
			from pointofsale where master_id = a.master_id)),
			cgp = (select sum(qty * func_getgp(product.pr_id,(price - bill_memo_product.discount))) from 
			bill_memo_product key join inv_main key join product key join bill_memo  where "date" = date(:mdate) and pos_id in(select pos_id 
			from pointofsale where master_id = a.master_id))
            FROM "pos_master"   as a where sale is not null
        union
        SELECT "pos_name" = 'Direct Sale',   
                id =null,
                    sale = (select sum(if type = 'S' then total_amt else -total_amt endif) from bill_memo
                    where "date" = date(:mdate) and pos_id is null ),
                    gp = (select sum(gross_profit) from bill_memo key join bill_memo_product 
                    where "date" = date(:mdate) and pos_id is null) ,
                    cgp = 0
            FROM dummy where sale is not null order by pos_name`,
    'tunnel:get:business:health': `
        declare @customValue varchar(128) 
    	declare @custom decimal 
	    set @customValue = (select MValue from KVSetting where MKey = 'customFigures') 
	    set @custom = (SELECT sum(row_value) FROM sa_split_list( @customValue )) 
	    select OPStockValue=(sum(op * (if P.op_price is null then 0 else P.op_price endif))), 
		ClosStockValue = (sum((op+db-cr) * (if p.last_price is null or P.last_price = 0 then P.op_price else P.last_price endif))), 
	    StockOver90Days = ( select sum((op+db-cr) *(if p1.last_price is null or P1.last_price=0 then P1.op_price else P1.last_price endif)) 
	    from inv_main I1 key join product P1 where P1.last_date < dateAdd(day,-90,getdate())), 
	    StockOver180Days = ( select sum((op+db-cr) *(if p1.last_price is null or P1.last_price=0 then P1.op_price else P1.last_price endif)) 
	    from inv_main I1 key join product P1 where P1.last_date < dateAdd(day,-180,getdate())), 
	    StockOver270Days = ( select sum((op+db-cr) *(if p1.last_price is null or P1.last_price=0 then P1.op_price else P1.last_price endif)) 
	    from inv_main I1 key join product P1 where P1.last_date < dateAdd(day,-270,getdate())), 
	    StockOver360Days = ( select sum((op+db-cr) *(if p1.last_price is null or P1.last_price=0 then P1.op_price else P1.last_price endif)) 
	    from inv_main I1 key join product P1 where P1.last_date < dateAdd(day,-360,getdate())), 
	    StockValueDiff=ClosStockValue - OPStockValue into #Stock 
	    from inv_main I key join product P 
	    select Profit = sum(acc_opBal + acc_db - acc_cr) into #Profit 
	    from acc_main where acc_root in('Y','L') and acc_type in('A','L') 
	    select #Stock.opStockValue, #Stock.closStockValue, #Stock.stockValueDiff,#Stock.stockOver90Days,#Stock.stockOver180Days,#Stock.stockOver270Days,#Stock.stockOver360Days, #Profit.profit, grossProfit = #Stock.stockValueDiff + #Profit.profit  
	    +@custom from #stock, #Profit
        `,
    'tunnel:get:final:accounts': `exec sp_acc_final_accounts :type 
        select profitloss = func_getprofitloss(), 
        total = 
        if profitloss > 0 then
            if :type = 'L' then
                (-func_gettotal(:type) + profitloss)
            else 
                if :type = 'A' then
                    func_gettotal(:type)
                else 
                    if :type = 'E' then
                        func_gettotal(:type) + profitloss
                    else
                        -func_gettotal(:type)
                    endif
                endif
            endif
        else
            if :type = 'L' then
                (-func_gettotal(:type) )
            else 
                if :type = 'A' then
                    func_gettotal(:type) - profitloss
                else 
                    if :type = 'E' then
                        func_gettotal(:type) 
                    else
                        -func_gettotal(:type) - profitloss
                    endif
                endif
            endif
        endif from dummy`,
    'tunnel:get:cheque:payments': `SELECT "cheque_payment"."ref_no",   
         "cheque_payment"."cheq_no", 
         "cheque_payment"."cheq_date",  
         "cheque_payment"."cheq_amt",   
         "cheque_payment"."acc_id_bank",   
         "cheque_payment"."remarks", 
    		pay_from = func_getaccname(acc_id_bank),
			pay_to = func_getaccname(acc_id)
        FROM "cheque_payment" order by cheq_date desc`,
    'tunnel:get:cash:payments': `SELECT  top 200 
         "cash_payment"."cp_date",  
        "cash_payment"."ref_no", 
			"cash_payment"."cp_id",    
         "cash_payment"."cp_amt",                
         "cash_payment"."remarks",   
			pay_from = func_getaccname(cp_acc_id_cash),
			pay_to = func_getaccname(cp_acc_id)			
        FROM "cash_payment"   order by cp_date desc`,
    'tunnel:get:debit:credit:notes': `SELECT  "debit_credit_note"."dc_date",
        "debit_credit_note"."ref_no",
        acc_name_db = func_getaccname(acc_id_db),
			acc_name_cr = func_getaccname(acc_id_cr),
			"debit_credit_note"."dc_id",    
         "debit_credit_note"."remarks",   
         "debit_credit_note"."dc_amt"  , 
         class_db = func_getclass(acc_id_db),
			class_cr = func_getclass(acc_id_cr)			
        FROM "debit_credit_note" 
        where (class_db  like :class_db and
		class_cr  like :class_cr) or (dc_id = ifnull(:tempid,0,:tempid))
	    order by dc_date desc`,
    'tunnel:get:jakar:on:days': `SELECT counter_code,
			total_value = (select sum((op+db-cr) *  if last_price is null or last_price = 0
			then product.op_price else last_price endif)
			from inv_main key join product
			key join counter where
			counter_code = a.counter_code) ,
			jakar_value = (select sum((op+db-cr) *  if last_price is null or last_price = 0
			then product.op_price else last_price endif)
			from inv_main key join product
			key join counter where
			counter_code = a.counter_code and last_date <= DATEADD(day,-:mdays,today())),
			percent = jakar_value * 100 / (if total_value is null or total_value = 0 then 1 else total_value endif)
            from counter as a group by counter_code order by counter_code`,
    'tunnel:get:jakar:details': `select item, brand, model, qty=(op+db-cr), value=Qty*(if last_price is null or last_price = 0
			then product.op_price else last_price endif), days = DATEDIFF(day,last_date,today())
            from inv_main key join product key join counter
            where counter_code = :counter_code and last_date <= DATEADD(day,-:mdays,today()) and Qty <>0
            order by days desc`,
    'tunnel:get:sale:details1': `SELECT "bill_memo"."bill_memo_id",      
         "bill_memo"."ref_no",   
         "bill_memo"."descr",    
			total_amt = if type = 'S' then total_amt else - total_amt endif,         
			gp = (select sum(gross_profit) from bill_memo_product where
					bill_memo_id = bill_memo.bill_memo_id),
			"cgp" = (select sum(qty * func_getgp(product.pr_id,price)) from 
				bill_memo_product key join inv_main key join product where 
				bill_memo_id = bill_memo.bill_memo_id)
            FROM "bill_memo" where "date" = :mdate and pos_id in(select pos_id from pos_master
		    key join pointofsale where pos_master.master_id = :master_id)`,
    'tunnel:get:sale:details:product': `select item,brand,model,qty=(if type ='s' then qty else -qty endif),price, value=qty*price, gp=gross_profit, cgp = qty * func_getgp(product.pr_id,price), days= DATEDIFF(day,last_date,bill_memo."date"), stock = (op+db-cr)
            from bill_memo_product key join inv_main key join product key join bill_memo  
            where "date" = date(:mdate)
            order by item,brand,model`,
    'tunnel:get:sale:details2': `SELECT  A."qty",   
        A."price",
        stock = (op+db-cr),
        cr,
		amount = qty * price,
        item,
        brand,
        model,
        ageing=DAYS(last_date,b."Date")
        FROM Bill_memo B key join "bill_memo_product" A   key join inv_main I key join product
            where A.bill_memo_id = :bill_memo_id`,
    'tunnel:get:ledger': `exec sp_accledger :accid update temp_ledger set ref_no = 'Opening' where accname='Opening Balance' select * from temp_ledger order by "date" desc`,
    'tunnel:get:banks': `SELECT "acc_main"."acc_id",   
                "acc_main"."acc_code",   
                "acc_main"."acc_name",
                    balance = acc_opbal + acc_db -acc_cr  
            FROM "acc_main"   where
                func_getclass(acc_id) = 'BANK'
            and acc_root = 'Y' 
            and not (acc_opbal = 0 and acc_db = 0 and acc_cr = 0)
        order by acc_name`,
    'tunnel:get:bank:recon:details': `SELECT "bank_recon"."tran_date",  		  
         "bank_recon"."debit_amt",   
         "bank_recon"."credit_amt",  
         "bank_recon"."remarks",   
         "bank_recon"."clear_date",
           mdate= if clear_date is null then date('9999-03-31') else clear_date endif,
         "bank_recon"."cheq_no",   
         "bank_recon"."acc_id",   
         "bank_recon"."cleared"  ,
			"acc_main"."acc_name"
        FROM "bank_recon"   left outer join "acc_main" on  
        bank_recon.acc_id  = acc_main.acc_id 
        where acc_id_bank = :accidbank order by mdate desc`,
    'tunnel:get:orders': `SELECT "counter"."counter_code",
		stock = (op+db-cr),
		price= if last_price=0 then product.op_price else last_price endif,
		Sale30Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID = a.inv_main_id and bill_memo."date" >= (getdate() - 30) ),
        Sale30to60Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID =a.inv_main_id and bill_memo."date" >=  (getdate() - 60) and bill_memo."date" <  (getdate() - 30)),
        Sale60to90Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID = a.inv_main_id and bill_memo."date" >=  (getdate() - 90) and bill_memo."date" <  (getdate() - 60)),		
        COrder = TRUNCNUM(0.60*(IFNULL(Sale30Days,0,Sale30Days))  + 0.30*IFNULL(Sale30to60Days,0,Sale30to60Days) + 0.10*IFNULL(Sale60to90Days,0,Sale60to90Days),0)  - stock,
		"Order" = if COrder > 0 then COrder else 0 endif,
        orderValue = "order" * price,
		IsUrgent = if "Order" >0 and stock<=0 then 1 else 0 endif
        into #temp
            FROM  "counter"  key join "product" left outer join "inv_main" a
        where 
                show='Y' and IsFitToOrder=1
        order by counter_code
        select  counter = counter_code, "orderQty" = sum("Order"), "value" = SUM(orderValue), urgent = SUM(IsUrgent) from #temp where orderValue <> 0 group by counter_code order by Counter_code`,
    'tunnel:get:order:details': `SELECT  counter="counter"."counter_code",
        brand,item,
		stock = (op+db-cr),
		price= if last_price=0 then product.op_price else last_price endif,
		Sale30Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID = a.inv_main_id and bill_memo."date" >= (getdate() - 30) ),
        Sale30to60Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID =a.inv_main_id and bill_memo."date" >=  (getdate() - 60) and bill_memo."date" <  (getdate() - 30)),
        Sale60to90Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID = a.inv_main_id and bill_memo."date" >=  (getdate() - 90) and bill_memo."date" <  (getdate() - 60)),
        COrder = TRUNCNUM(0.60*(IFNULL(Sale30Days,0,Sale30Days))  + 0.30*IFNULL(Sale30to60Days,0,Sale30to60Days) + 0.10*IFNULL(Sale60to90Days,0,Sale60to90Days),0)  - stock,
		"Order" = if COrder > 0 then COrder else 0 endif,
        orderValue = "order" * price, IsUrgent = if "Order" >0 and stock<=0 then 1 else 0 endif
        into #temp
        FROM  "counter"  key join "product" left outer join "inv_main" a
        where 
            show='Y' and IsFitToOrder = 1
        order by counter,brand,item
        select brand,item, "orderQty" = sum("Order"), "value" = SUM(orderValue), counter, urgent = SUM(IsUrgent) from #temp where orderValue <> 0 and counter=:counter group by counter,brand,item order by counter,brand,item`,
    'tunnel:place:order':`select item,brand,model,"order",supply into #temp from sp_retrieve_order_status()
        SELECT "counter"."counter_code",   
         "product"."item",   
         "product"."brand",   
         "product"."model",   
		stock = (op+db-cr),totalSale=cr, 
		price= if last_price=0 then product.op_price else last_price endif,
		sale30Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID = a.inv_main_id and bill_memo."date" >= (getdate() - 30) ),
        sale30to60Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID =a.inv_main_id and bill_memo."date" >=  (getdate() - 60) and bill_memo."date" <  (getdate() - 30)),
        sale60to90Days = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID = a.inv_main_id and bill_memo."date" >=  (getdate() - 90) and bill_memo."date" <  (getdate() - 60)),
		saleOld = (select sum(qty) from bill_memo_product b key join bill_memo where b.inv_main_ID =a.inv_main_id and  bill_memo."date" <  (getdate() - 90)),
        cOrder = TRUNCNUM(0.60*(IFNULL(Sale30Days,0,Sale30Days))  + 0.30*IFNULL(Sale30to60Days,0,Sale30to60Days) + 0.10*IFNULL(Sale60to90Days,0,Sale60to90Days),0)  - stock,
		"order" = if COrder > 0 then COrder else 0 endif,
		finalOrder = 0,
		orders=(select SUM("order") from #temp t where t.item = product.item and t.brand=product.brand and t.model=product.model ),
		supply=(select SUM(supply) from #temp t where t.item = product.item and t.brand=product.brand and t.model=product.model ), orderValue = "order"*price,
        remarks=space(40)
        FROM  "counter"  key join "product" left outer join "inv_main" a
        where item = :item 
        and brand = :brand
        and counter_code = :counter
		and show='Y'
        order by counter_code,item,brand,model`,
    'tunnel:get:final:accounts':`exec sp_acc_final_accounts 'L'`
};
module.exports = sql;