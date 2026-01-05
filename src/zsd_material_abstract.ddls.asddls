
@EndUserText.label: 'Material F4 Help using Abstract Entity'
define abstract entity ZSD_MATERIAL_ABSTRACT
//  with parameters parameter_name : parameter_type
{

@Consumption.valueHelpDefinition: [{
      entity: { name: 'I_SalesOrderItem', element: 'SalesOrderItem' },
      additionalBinding: [{
          localElement: 'vbeln',
          element: 'SalesOrder'
      }]
  }]

posnr : posnr;
    vbeln : vbeln;

 
    
}
