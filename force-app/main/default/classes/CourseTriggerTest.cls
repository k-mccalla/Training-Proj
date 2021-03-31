@isTest

private class CourseTriggerTest{

    @testSetup static void setupData(){
     
        User thisUser = [ select Id from USER where Id = :UserInfo.getUserId() ];
        System.runAs (thisUser){
            // List<Invoice__c> testInv = LoadDataTestFactory.loadInvoices();
            // List<Course__c> testCourses = LoadDataTestFactory.loadCourses();

        }
    }


@isTest

   public static void createTestEvents() { 
Test.startTest();
    {
        Map<Id,Opportunity> InstructorMap = new Map<Id,Opportunity>([SELECT Id, Course_rate__r.Instructor__c FROM Opportunity WHERE Id IN : OppSet]);
        Event h = new Event();
        h.StartDateTime = Date.newInstance(Date.today().year(), 9, 1);
        h.Subject = 'a';
       // h.Location -'United Kingdom';
        h.DurationInMinutes = 60;
        h.OwnerId = InstructorMap.get(h.Id).Course_rate__r.Instructor__c;


          List<Event> events = new List<Event>();
          Events.add(h);
          Database.SaveResult[] saveResults = Database.insert(events, false);
        

        Event testEvent = new Event(Subject = 'Name', IsRecurrence = false, DurationInMinutes = 60);
        //ActivityDateTime = System.Today());
        testEvent.DurationInMinutes = 60;
        insert testEvent;

        //  Test.StartTest();
        //  try
        //  {
        //    Insert h;
        //    insert testEvent;
        //  }
        //  catch(Exception ifEventHandlerFailed){ };
        //  Test.StopTest();    

    }
    Test.stopTest();
}
 
}



