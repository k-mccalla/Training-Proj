@isTest
public with sharing class CustomControllerTest {

    @testSetup static void setupData(){
     
        
            List<Invoice__c> testInv = LoadDataTestFactory.loadInvoices();
            List<Course__c> testCourses = LoadDataTestFactory.loadCourses();

        }
    

    @isTest 
    private static void DataUtil {
        static testmethod void testLoadData()
         //testLoadData(); 
         {
        
            List<sObject> ls = Test.loadData(Opportunity.sObjectType, 'Course_data1');
            
            System.assert(ls.size() == 3);
     
            
            Opportunity a1 = (Opportunity)ls[0];
            String Name = a1.Name;
            System.debug(Name);
     
            // Perform some testing using the test records
        }
    
}
 @isTest
 private static void controllerTest() {
            test.startTest();

           //List<Invoice__c objlist = customController.action();

          Course__c course = new Course__c();
          course.Name = 'test course';
            Invoice__c inv = new Invoice__c();
            inv.Name = ' test 1';

           insert inv;

           test.stopTest();
    }
    


    }


