// library reportsLib;
const reports = {
  "sales": {
    "isDateChangeButtonsVisible": true,
    "drillDownReport": "saleDetails1",
    "idName": "id",
    "detailsReport": "detailedSales",
    "fixedBottom": [
      {"title": "Total sale:", "name": "sale"},
      {"title": "Gp:", "name": "gp"},
      {"title": "Cgp:", "name": "cgp"}
    ],
    "body": [
      {
        "title": "Pos",
        "name": "pos_name",
        "width": 70.0,
      },
      {
        "title": "Sale",
        "name": "sale",
        "width": 80.0,
        "isSum": true,
        "alignment": 'right'
      },
      {
        "title": "GP",
        "name": "gp",
        "width": 70.0,
        "isSum": true,
        "alignment": 'right'
      },
      {
        "title": "Cgp",
        "name": "cgp",
        "width": 70.0,
        "isSum": true,
        "alignment": 'right'
      }
    ]
  },
  "saleDetails1": {
    "drillDownReport": "saleDetails2",
    "idName": "bill_memo_id",
    "fixedBottom": [
      {"title": "Total sale:", "name": "total_amt"},
      {"title": "Gp:", "name": "gp"},
      {"title": "Cgp:", "name": "cgp"}
    ],
    "body": [
      {"title": "Ref", "name": "ref_no", "width": 90.0},
      {
        "title": "Amount",
        "name": "total_amt",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Gp",
        "name": "gp",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Cgp",
        "name": "cgp",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      },
    ]
  },
  "saleDetails2": {
    "body": [
      {"title": "Product", "name": "item,brand,model", "width": 90.0},
      {"title": "Qty", "name": "qty", "width": 90.0},
      {"title": "Price", "name": "price", "width": 90.0},
      {"title": "Amount", "name": "amount", "width": 90.0},
      {"title": "Old", "name": "ageing", "width": 90.0},
      {"title": "Stk", "name": "stock", "width": 90.0},
    ]
  },
  "orders": {
    "drillDownReport": "orderDetails",
    "idName": "counter",
    "fixedBottom": [
      {"title": "Order value:", "name": "value"}
    ],
    "body": [
      {"title": "Counter", "name": "counter", "width": 120.0},
      {
        "title": "Qty",
        "name": "orderqty",
        "width": 50.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Value",
        "name": "value",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Urgent",
        "name": "urgent",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      }
    ]
  },
  "orderDetails": {
    "fixedBottom": [
      {"title": "Order value:", "name": "value"}
    ],
    "body": [
      {"title": "Product", "name": "item,brand", "width": 120.0},
      {
        "title": "Order",
        "name": "orderqty",
        "width": 50.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Value",
        "name": "value",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Urgent",
        "name": "urgent",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      }
    ]
  },
  "chequePayments": {
    "body": [
      {"title": "Date", "name": "cheq_date", "width": 80.0},
      {"title": "Party", "name": "pay_to", "width": 155.0},
      {"title": "Amt", "name": "cheq_amt", "width": 80.0, "alignment": 'right'},
      {
        "title": "Cheq",
        "name": "cheq_no",
        "width": 80.0,
        "alignment": 'center'
      },
      {"title": "Ref", "name": "ref_no", "width": 60.0},
      {"title": "From", "name": "pay_from", "width": 60.0},
      {"title": "Rem", "name": "remarks", "width": 120.0}
    ]
  },
  "cashPayments": {
    "body": [
      {"title": "Date", "name": "cp_date", "width": 80.0},
      {"title": "Account", "name": "pay_to", "width": 155.0},
      {"title": "Amt", "name": "cp_amt", "width": 80.0, "alignment": 'right'},
      {"title": "Ref", "name": "ref_no", "width": 100.0, "alignment": 'center'},
      {"title": "Remarks", "name": "remarks", "width": 140.0}
    ]
  },
  "debitNotes": {
    "body": [
      {"title": "Date", "name": "dc_date", "width": 80.0},
      {"title": "Name", "name": "acc_name_db", "width": 155.0},
      {"title": "Amt", "name": "dc_amt", "width": 80.0, "alignment": 'right'},
      {"title": "Ref", "name": "ref_no", "width": 100.0, "alignment": 'center'},
      {"title": "Remarks", "name": "remarks", "width": 140.0}
    ]
  },
  "creditNotes": {
    "body": [
      {"title": "Date", "name": "dc_date", "width": 80.0},
      {"title": "Name", "name": "acc_name_cr", "width": 155.0},
      {"title": "Amt", "name": "dc_amt", "width": 80.0, "alignment": 'right'},
      {"title": "Ref", "name": "ref_no", "width": 100.0, "alignment": 'center'},
      {"title": "Remarks", "name": "remarks", "width": 140.0}
    ]
  },
  "banks": {
    "drillDownReport": "bankDetails",
    "idName": "acc_id",
    "body": [
      {"title": "Bank name", "name": "acc_name", "width": 130.0},
      {
        "title": "Balance",
        "name": "balance",
        "width": 100.0,
        "alignment": 'right'
      },
    ]
  },
  "bankDetails": {
    "body": [
      {"title": "Tran", "name": "tran_date", "width": 80.0},
      {"title": "Clear", "name": "clear_date", "width": 80.0},
      {"title": "Cheq", "name": "cheq_no", "width": 60.0},
      {"title": "Debit", "name": "debit_amt", "width": 90.0, "alignment": 'right'},
      {"title": "Credit", "name": "credit_amt", "width": 90.0, "alignment": 'right'},
      {"title": "Bal", "name": "balance", "width": 100.0, "alignment": 'right'},
      {"title": "Remarks", "name": "remarks", "width": 120.0, "alignment": 'center'},
    ]
  },
  "detailedSales": {
    "isDateChangeButtonsVisible": true,
    "fixedBottom": [
      {"title": "Total sale:", "name": "value"},
      {"title": "Gp:", "name": "gp"},
      {"title": "Cgp:", "name": "cgp"}
    ],
    "body": [
      {"title": "Product", "name": "item,brand,model", "width": 90.0},
      {"title": "Qty", "name": "qty", "width": 30.0, "alignment": 'right'},
      {"title": "Price", "name": "price", "width": 70.0, "alignment": 'right'},
      {
        "title": "Amount",
        "name": "value",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Gp",
        "name": "gp",
        "width": 60.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Cgp",
        "name": "cgp",
        "width": 60.0,
        "alignment": 'right',
        "isSum": true
      },
      {"title": "Stk", "name": "stock", "width": 40.0, "alignment": 'right'},
      {"title": "Old", "name": "days", "width": 40.0, "alignment": 'right'},
    ]
  }
};
