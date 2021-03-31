public with sharing class CourseTriggerHandler {


        public static void ManangeCourseEvents(list<Opportunity> oppsIn, Map<Id,Opportunity> oldOppsIn){

        

            List<Event> lstNewEvents = new List<Event>();
            List<Opportunity> oppToInsert = new List<Opportunity>();
            List<Opportunity> oppToUpdate = new List<Opportunity>();
            List<Opportunity> oppToDelete = new List<Opportunity>();

   Set<Id> OppSet = new Set<Id>();

   for (Opportunity opp: OppsIn){

    OppSet.Add(opp.Id); 
   
//  If (opp == oldOppsIn.get(opp.Id))
if(oldOppsIn == Null || oldOppsIn.get(opp.Id) == Null){
    oppToInsert.Add(opp);
}

  else if(opp.StageName == 'Cancelled' && oldOppsIn.get(opp.Id).StageName != 'Cancelled'){
        oppToDelete.Add(opp);
    }

      else (oppToInsert.Add(opp));



        
}

   Map<Id,Opportunity> InstructorMap = new Map<Id,Opportunity>([SELECT Id, Course_rate__r.Instructor__c FROM Opportunity WHERE Id IN : OppSet]);


    if(oppToInsert.size() > 0){
    
for(Opportunity eve: OppsIn){
    


    Event e = new Event();

    e.StartDateTime = eve.Start_Date__c;
    e.EndDateTime = eve.CloseDate;
    e.Subject = eve.Course_Type__c + ' ' + eve.Start_Date__c.format();
    e.Location = eve.Location__c;
    e.WhatId = eve.Id;
   
   e.OwnerId = InstructorMap.get(eve.Id).Course_rate__r.Instructor__c;
    
   lstNewEvents.add(e);

}
    
}
{
System.debug(lstNewEvents);
    insert lstNewEvents;
        }
    if(oppToDelete.size()> 0){
List<Event> events = [SELECT Id FROM Event WHERE WhatId IN : oppToDelete];
delete events;

 }




    //Event e = new Event();
  if(oppToUpdate.size() > 0){
      Map<Id, Event> eventMap = new Map<Id,Event>();
    // for(Opportunity eve: oppToUpdate){
        List<Event> events1 = [SELECT Id, WhatId FROM Event WHERE WhatId IN : oppToUpdate];
        List<Event> events2 = New List<Event>();

         for(Event event: events1){
              eventMap.put(event.WhatId, event); 
         }
for(Opportunity opp: oppToUpdate){
        Event e = eventMap.get(opp.Id);

        e.StartDateTime = opp.Start_Date__c;
    e.EndDateTime = opp.CloseDate;
    e.Subject = opp.Course_Type__c + ' ' + opp.Start_Date__c.format();
    e.Location = opp.Location__c;

    eventMap.put(opp.Id, e);
       }
        
        update eventMap.values();
  
    } 
        
        
 }
public static void sendEmails(List<Opportunity> oppsToSend){

    List<Messaging.SingleEmailMessage> mailsToSend = new List<messaging.SingleEmailMessage>();
    EmailTemplate et=[Select id, Subject, Body from EmailTemplate where name= 'Cancellation email' limit 1];
    EmailTemplate etScheduled=[Select id, Subject, Body from EmailTemplate where name= 'Scheduled Email' limit 1];
    List<Opportunity> lstcon=[Select id, Name, Course_Rate__r.Instructor__r.name, Course_Rate__r.Instructor__r.email, StageName from Opportunity where id IN : oppsToSend ];
    List<String> toAddresses = new List<String>();
    for(Opportunity opp : lstCon){
    if (Opp.StageName == 'Cancelled'){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setTargetObjectIds(lstIds);
        toAddresses.add(opp.Course_rate__r.Instructor__r.email);
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('System Admin');
        mail.setTemplateId(et.id);
        mail.setSubject(et.subject);
        mail.setHtmlBody(et.body);
        mail.setWhatId(opp.Id);
        mailsToSend.add(mail);
    }else if (Opp.StageName == 'Scheduled'){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setTargetObjectIds(lstIds);
        toAddresses.add(opp.Course_rate__r.Instructor__r.email);
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('System Admin');
        mail.setTemplateId(etScheduled.id);
        mail.setHtmlBody(etScheduled.body);
        mail.setSubject(etScheduled.subject);
        mail.setWhatId(opp.Id);
        mailsToSend.add(mail);
    }
   
}
 Messaging.sendEmail(mailsToSend);

    }
    
    public static void invoiceOpps(list<Opportunity> oppsIn, Map<Id,Opportunity> oldOppsIn){
List<Opportunity> lstOpp = new List<Opportunity>();
List<Invoice__c> inlist = new List<Invoice__c>();
for (Opportunity opp1: (list<Opportunity>) oppsIn){
    if (opp1.StageName == 'Completed'){
 //inlist.add(

    Invoice__c invoice = new Invoice__c();
          
            invoice.Invoice_Date__c = date.today();
            invoice.Status__c = 'Draft';
            invoice.Name='TestInvoice';
            invoice.Course__c = opp1.ID;
           
         
    
             inlist.add(invoice);
            //    lstOpp.add(opp1);
    
    }
}
    
insert inlist;

// }
//     if(lstOpp.size() > 0)
//     for(Opportunity course : lstOpp){
//         Invoice__c i = new Invoice__c();
//         i.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Service_Invoice').getRecordTypeId();
//         i.Name = 'Test Invoice';
//         //i.Status__c = course.Status__c;
//         i.Invoice_Date__c = date.today();
//         i.Course__c = course.Name;
          
//         //i.Invoice_Owner__c = course.Course_rate__r.Instructor__c;
        
//         inlist.add(i);
//         i.put(course.Id, i);
       

//        } 
//        insert inlist;
    }
}


 public static void AutoAddInvoiceLineItems (List<Invoice__c> newInvoice, Map<Id,Invoice__c> newInvoiceMap){
     Set<Id> invoiceIdSet= new Set<Id>(); 
     Set<Id> OppyIdSet= new Set<Id>();
    
     String OrderOppy;
     Invoice__c ivc = new Invoice__c();
     for (Invoice__c o : newInvoice){            
         invoiceIdSet.add(o.Id);
         if (o.Course__c != NULL){
             OppyIdSet.add(o.Course__c);
            OrderOppy = 'Course';
       }
    
    
}  




    for(Invoice__c i : inlist(){
         Invoice_Line_Item__c il = new 	Invoice_Line_Item__c();
       il.	RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Service').getRecordTypeId();
        il.	Date__c = i.Invoice_Date__c;
         il.Amount__c = '0'; 
      }

        
   
   insert il.values();
    }

}
}


}

    
        
           





 




