public class CustController {


 private final Invoice__c account;

        public CustController() { 
        
       account = [SELECT Id, 		Invoice_Date__c, 	Invoice_Owner__c, Invoice_Number__c, RecordTypeId, Course__c, 	Tax_rate__c, 	
            VAT__c, 	Subtotal__c, Name, 	VAT_Total__c,
            VAT_Rate__c, Tax_amount__c, 	Invoice_Total__c
    
    
            FROM Invoice__c 
            where Id = : ApexPages.currentPage().getParameters().get('id')];
            
   
    }
    
     
    public Invoice__c getInvoices() {
        return account;
    }
 
    public PageReference save() {
        update account;
        return null;
    
    }
    
         public static List<Invoice_Line_Item__c> getlineItems() {
             List<Invoice_Line_Item__c> results = [
                 SELECT Id, 	Amount__c, 	Description_of_expense__c, 	Date__c, Invoice__c, Name, VAT__c, Total_Amount__c
                 FROM Invoice_Line_Item__c 
                 where Invoice__c = :ApexPages.currentPage().getParameters().get('id')
             ];
           return results;
        }
    
        }
   
     
    
    
    
