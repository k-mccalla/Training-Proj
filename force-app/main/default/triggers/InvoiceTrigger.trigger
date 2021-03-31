trigger InvoiceTrigger on Invoice (before insert, after insert) {


  //  if(Trigger.isAfter){
            InvoiceTriggerHandler.pdfAttachment(Trigger.new);

}
    
