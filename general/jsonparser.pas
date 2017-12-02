unit jsonparser;


interface
uses System.Json;

function ParsetoJson(sku,skusize,barcode,description,price:string):string ;

implementation

 function ParsetoJson(sku,skusize,barcode,description,price:string):string ;
 var
  Obj: TJSONObject;
 begin
    Obj := TJSONObject.Create;
  //  Obj.AddPair('id', index);
    Obj.AddPair('sku', sku);
    Obj.AddPair('skusize', skusize);
    Obj.AddPair('barcode', barcode);
    Obj.AddPair('description', description);
    Obj.AddPair('price', price);
    result:=  Obj.toJson ;
 obj.Free;
 end;


end.
