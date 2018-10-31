// library reportsLib;
const reports = {
  "sales": {
    "body": [
      {"title": "Pos", "name": "pos_name", "width": 70.0,},
      {"title": "Sale", "name": "sale", "width": 80.0, "isSum":true, "alignment":'right'},
      {"title": "GP", "name": "gp", "width": 70.0, "isSum":true, "alignment":'right'},
      {"title": "Cgp", "name": "cgp", "width": 70.0, "isSum":true, "alignment": 'right'}
    ]
  },
  "detailedSales": {
    "body":[
      {"title":"Product", "name":"item", "width": 90.0},
      {"title":"Qty", "name":"qty", "width":30.0 , "alignment":'right'},
      {"title":"Price", "name":"price", "width":70.0 , "alignment":'right'},
      {"title":"Amount", "name":"value", "width": 90.0 , "alignment":'right'},
      {"title":"Gp", "name":"gp", "width": 60.0 , "alignment":'right',"isSum":true},
      {"title":"Cgp", "name":"cgp", "width": 60.0 , "alignment":'right'},
      // {"title":"Days", "name":"days", "width": 40.0 , "alignment":'right'},
      {"title":"Stk", "name":"stock", "width": 40.0 , "alignment":'right'},
    ]
  
  }
};
