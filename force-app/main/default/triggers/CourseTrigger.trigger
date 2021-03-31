
trigger CourseTrigger on Opportunity (after insert, after update, after delete) { 



// if(Trigger.isAfter){
//     if(Trigger.isInsert){
//         CourseTriggerHandler.invoiceOpps(Trigger.new);
//        // CourseTriggerHandler.SendEmails(Trigger.new);
//     }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            CourseTriggerHandler.ManangeCourseEvents(Trigger.new,Trigger.oldMap);
            //CourseTriggerHandler.SendEmails(Trigger.new);
        }
        else if(Trigger.isUpdate){
            CourseTriggerHandler.ManangeCourseEvents(Trigger.new,Trigger.oldMap);
          //  CourseTriggerHandler.SendEmails(Trigger.new);
        }
    }
}

//}

 
