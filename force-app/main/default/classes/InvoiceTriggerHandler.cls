public with sharing class InvoiceTriggerHandler {
    public static void pdfAttachment() {
 
            //PageReference pdf = Page.'CreatePDF';
            
            List<Invoice> newInvoices = new List<Invoice>();
            for(Invoice invoice : newInvoices){
        
        Attachment attach = new Attachment();
         
            attach.Name = 'Invoice' + newInvoices.Name”;
            attach.IsPrivate = true;
            attach.Id= newInvoices.Invoice_Number__c;
            insert attach;
            
            }
     List<Attachment> attachList = new List<attachment>();{
     if (attachList() > 0){
        return attachList;
      }
    }
 

  try {
    insert attach;


   } catch (Exception e) {
    System.debug(LoggingLevel.ERROR, e.getMessage());

    final String errorMsg = 'An error has occured while generating the invoice' +
                             e.getMessage();
                            
    
    return errorMsg;
 }

    }
    }

