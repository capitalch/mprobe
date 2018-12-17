// library reportsLib;
var reports = {
  "sales": {
    "isDateChangeButtonsVisible": true,
    "drillDownRoute": "saleDetails1",
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
      },
      {
        "title": "Add",
        "name": "add",
        "width": 60.0,
        // "isComputed": true,
        "alignment": 'right',
        "compute": (result) {
          // double.tryParse(result['gp']) + double.tryParse(result['cgp'])
          print(result);
          return (double.tryParse(result['gp']) + double.tryParse(result['gp']))
              .toString();
        }
      }
    ]
  },
  "saleDetails1": {
    "drillDownRoute": "saleDetails2",
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
    "drillDownRoute": "orderDetails",
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
    "drillDownRoute": "bankDetails",
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
      {
        "title": "Debit",
        "name": "debit_amt",
        "width": 90.0,
        "alignment": 'right'
      },
      {
        "title": "Credit",
        "name": "credit_amt",
        "width": 90.0,
        "alignment": 'right'
      },
      {"title": "Bal", "name": "balance", "width": 100.0, "alignment": 'right'},
      {
        "title": "Remarks",
        "name": "remarks",
        "width": 120.0,
        "alignment": 'center'
      },
    ]
  },
  "jakar": {
    "drillDownRoute": "jakarDetails",
    "idName": "counter_code",
    "fixedBottom": [
      {"title": "Jakar value:", "name": "jakar_value"}
    ],
    "body": [
      {"title": "Counter", "name": "counter_code", "width": 110.0},
      {
        "title": "Total",
        "name": "total_value",
        "width": 100.0,
        "alignment": 'right',
        "isSum": true
      },
      {
        "title": "Jakar",
        "name": "jakar_value",
        "width": 90.0,
        "alignment": 'right',
        "isSum": true
      },
      {"title": "%", "name": "percent", "width": 30.0, "alignment": 'right'},
    ]
  },
  "jakarDetails": {
    "fixedBottom": [
      {"title": "Jakar value:", "name": "value"}
    ],
    "body": [
      {"title": "Product", "name": "item,brand,model", "width": 130.0},
      {"title": "Qty", "name": "qty", "width": 40.0, "alignment": 'right'},
      {
        "title": "Value",
        "name": "value",
        "width": 90.0,
        "isSum": true,
        "alignment": 'right'
      },
      {"title": "Days", "name": "days", "width": 60.0, "alignment": 'right'},
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
  },
  'itemsOnBrand': {
    "drillDownRoute": "detailsOnItemBrand",
    'idName': 'item',
    'body': [
      {'title': 'Items', 'name': 'item', 'width': 200.0},
      {
        'title': 'ModelCount',
        'name': 'modelcount',
        'width': 90.0,
        'alignment': 'right'
      }
    ]
  },
  'detailsOnBrand': {
    'drillDownRoute': 'productDetails',
    'idName': 'pr_id',
    'body': [
      {'title': 'Product', 'name': 'item,model', 'width': 120.0},
      {'title': 'Stk', 'name': 'stock', "alignment": 'right', 'width': 30.0},
      {
        'title': 'GstCost',
        'name': 'gstcost',
        "alignment": 'right',
        'width': 90.0
      },
      {
        'title': 'Basic',
        'name': 'basiccost',
        "alignment": 'right',
        'width': 90.0
      },
      {'title': 'Gst', 'name': 'gst', "alignment": 'right', 'width': 40.0},
    ]
  },
  'detailsOnItemBrand': {
    'drillDownRoute': 'productDetails',
    'idName': 'pr_id',
    'body': [
      {'title': 'Model', 'name': 'model', 'width': 120.0},
      {'title': 'Stk', 'name': 'stock', "alignment": 'right', 'width': 30.0},
      {
        'title': 'GstCost',
        'name': 'gstcost',
        "alignment": 'right',
        'width': 90.0
      },
      {
        'title': 'Basic',
        'name': 'basiccost',
        "alignment": 'right',
        'width': 90.0
      },
      {'title': 'Gst', 'name': 'gst', "alignment": 'right', 'width': 40.0},
    ]
  },
};
