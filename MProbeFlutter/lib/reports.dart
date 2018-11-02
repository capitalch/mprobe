// library reportsLib;
const reports = {
  "sales": {
    "isDateChangeButtonsVisible": true,
    "drillDownReport": "saleDetails1",
    "idName":"master_id",
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
    "idName":"bill_memo_id",
    "body": [
      {"title": "Ref", "name": "ref_no", "width": 90.0},
      {"title": "Amount", "name": "total_amt", "width": 90.0, "alignment": 'right',  "isSum": true},
      {"title": "Gp", "name": "gp", "width": 90.0,"alignment": 'right',  "isSum": true },
      {"title": "Cgp", "name": "cgp", "width": 90.0, "alignment": 'right',  "isSum": true},
    ]
  },
  "saleDetails2": {
    "idName":"bill_memo_id",
    "body": [
      {"title": "Product", "name": "item,brand,model", "width": 90.0},
      {"title": "Qty", "name": "qty", "width": 90.0},
      {"title": "Price", "name": "price", "width": 90.0},
      {"title": "Amount", "name": "amount", "width": 90.0},
      {"title": "Old", "name": "ageing", "width": 90.0},
      {"title": "Stk", "name": "stock", "width": 90.0},
    ]
  },
  "detailedSales": {
    "isDateChangeButtonsVisible": true,
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
