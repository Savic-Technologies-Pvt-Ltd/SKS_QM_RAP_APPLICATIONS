

@EndUserText.label: 'Material F4 Help using Abstract Entity'
define abstract entity ZSD_DELIVERY_ABSTRACT
//  with parameters parameter_name : parameter_type
{

//@Consumption.filter: { selectionType : #RANGE, multipleSelections : true}
 
@Consumption.valueHelpDefinition: [{
      entity: { name: 'I_DeliveryDocumentItem', element: 'DeliveryDocumentItem' },
      additionalBinding: [{
          localElement: 'vbeln',
          element: 'DeliveryDocument'
      }]
  }]

posnr : posnr;

   vbeln : vbeln;
 
    
}
