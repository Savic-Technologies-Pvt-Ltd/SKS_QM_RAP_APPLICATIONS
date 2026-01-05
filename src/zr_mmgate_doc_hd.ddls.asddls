@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Document Header'

define view entity ZR_MMGATE_DOC_HD as select from zmm_gate_doc_hd

association to parent ZR_MMGATE_HEAD as _header
    on $projection.Gatenumber = _header.Gatenumber and
     $projection.Plant = _header.plant
    
{
    key gatenumber as Gatenumber,
    key plant as Plant,
    key doc_num as doc_num,
    doc_date as doc_date,
    vendor as Vendor,
    vendorname as Vendorname,
    inwardtype         ,
    zmm_gate_doc_hd.createdby as Createdby,
    zmm_gate_doc_hd.creat_dat as CreatDat,
    zmm_gate_doc_hd.chan_by as ChanBy,
    zmm_gate_doc_hd.chan_at as ChanAt,
    zmm_gate_doc_hd.local_last_changed_at as LocalLastChangedAt,
    
    _header
}
