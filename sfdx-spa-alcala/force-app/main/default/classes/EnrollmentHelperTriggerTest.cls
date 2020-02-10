/**************************************************************************************************                             
* ----------------------------------------------------------------------------------------------- 
* Change History    AUTHOR            DATE                Description                          
* CH00              Jose              24/03/2018          Test class                           
***************************************************************************************************/
@isTest( seeAllData = false )
private class EnrollmentHelperTriggerTest {
    
    

    /***********************************************************************************************
    * Description : to test the student enrollment                        
    * Params      : void                                                      
    * Return      : void                                                                           
    ************************************************************************************************/
    
    @isTest static void test_method_one() {
        Test.startTest();
        Id teacherRecId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Staff').getRecordTypeId();
        Id studRecId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Student').getRecordTypeId();
        Id enrollmentJunior = Schema.SObjectType.Student_Year_Semester__c.getRecordTypeInfosByName().get('Junior Highschool').getRecordTypeId();
        Id enrollmentSenior = Schema.SObjectType.Student_Year_Semester__c.getRecordTypeInfosByName().get('Senior Highschool').getRecordTypeId();
      
        Id teachSubjJunior = Schema.SObjectType.Teacher_Subject__c.getRecordTypeInfosByName().get('Junior High').getRecordTypeId();
        Id teachSubjSenior = Schema.SObjectType.Teacher_Subject__c.getRecordTypeInfosByName().get('Senior High').getRecordTypeId();

        system.debug('##stud record type id is:'+studRecId);
        //create a student contact
            Contact studInsert = new Contact();
            studInsert.FirstName = 'Jim';
            studInsert.LastName = 'Doe';
            studInsert.ESC_Status__c = 'Retained';
            studInsert.Birthdate = Date.today();
            studInsert.Gender__c = 'Male';
            studInsert.RecordTypeId = studRecId;
            insert studInsert; 
        
         //create a staff contact
            Contact teacherIns = new Contact();
            teacherIns.FirstName = 'Lucila';
            teacherIns.LastName = 'Paz';
            teacherIns.Birthdate = Date.today();
            teacherIns.Gender__c = 'Female';
            teacherIns.RecordTypeId = teacherRecId;
            teacherIns.Staff_Role__c = 'Teacher';
            insert teacherIns; 
        
        // create a school level Junior High
          School_Level__c schLevelJuniorHigh = new School_Level__c();
          schLevelJuniorHigh.Name = 'Junior High';
          insert schLevelJuniorHigh;
        
          // create a school level Senior High
          School_Level__c schLevelSRHigh = new School_Level__c();
          schLevelSRHigh.Name = 'Senior High';
          insert schLevelSRHigh;
        
         
          //create a year level Junior
            Year__c yearLevelJunior = new Year__c();
            yearLevelJunior.Base_Fee__c = 2121;
            yearLevelJunior.Misc_Fee__c = 111;
            yearLevelJunior.Name = 'Grade 7';
            yearLevelJunior.School_Level__c = schLevelJuniorHigh.Id;
            insert yearLevelJunior; 
        
          //create a year level Senior
            Year__c yearLevelSenior = new Year__c();
            yearLevelSenior.Base_Fee__c = 2121;
            yearLevelSenior.Misc_Fee__c = 111;
            yearLevelSenior.Name = 'Grade 11';
            yearLevelSenior.School_Level__c = schLevelSRHigh.Id;
            insert yearLevelSenior; 
        
                  //create a year level Senior
            Year__c yearLevelSeniorGrade12 = new Year__c();
            yearLevelSeniorGrade12.Base_Fee__c = 2121;
            yearLevelSeniorGrade12.Misc_Fee__c = 111;
            yearLevelSeniorGrade12.Name = 'Grade 12';
            yearLevelSeniorGrade12.School_Level__c = schLevelSRHigh.Id;
            insert yearLevelSeniorGrade12; 
        
            //create a subject jr high
      
            Subjects__c subjInsJr = new Subjects__c();
            subjInsJr.Active__c = true;
            subjInsJr.Subject_Type__c = 'Core Subject';
            subjInsJr.Name = 'English 101';
            insert subjInsJr; 
        
             //create a subject Sr high
      
            Subjects__c subjInsSr = new Subjects__c();
            subjInsSr.Active__c = true;
            subjInsSr.Subject_Type__c = 'Core Subject';
            subjInsSr.Name = 'Filipino 102';
            insert subjInsSr; 
        
            Subjects__c subjInsSr12 = new Subjects__c();
            subjInsSr12.Active__c = true;
            subjInsSr12.Subject_Type__c = 'Core Subject';
            subjInsSr12.Name = 'Science 102';
            insert subjInsSr12; 
        
   
            //create a section Sr high
      
            Section__c sectionSr = new Section__c();
            sectionSr.Name = 'St. Thomas';
            sectionSr.Year__c = yearLevelSenior.Id;
            insert sectionSr; 
        
            Section__c sectionSrG12 = new Section__c();
            sectionSrG12.Name = 'St. Mark';
            sectionSrG12.Year__c = yearLevelSeniorGrade12.Id;
            insert sectionSrG12; 
        
             //create a section Jr high
      
            Section__c sectionJr = new Section__c();
            sectionJr.Name = 'St. John';
            sectionJr.Year__c = yearLevelJunior.Id;
            
        	insert sectionJr; 
        
            Section__c sectionJr2 = new Section__c();
            sectionJr2.Name = 'St. Juan';
            sectionJr2.Year__c = yearLevelJunior.Id;
            
        	insert sectionJr2; 
        
              //create semester for senior high
            Period_Semester__c firstSem = new Period_Semester__c();
            firstSem.Name = 'First Semester';
        	firstSem.Section__c = sectionSrG12.Id;
            insert firstSem;
            
            //create semester for senior high
            Period_Semester__c secondSem = new Period_Semester__c();
            secondSem.Name = 'Second Semester';
        	secondSem.Section__c = sectionSrG12.Id;
            insert secondSem;
        
        	// create teacher subject junior high
        	Teacher_Subject__c teachSubj1 = new Teacher_Subject__c();
        	teachSubj1.RecordTypeId = teachSubjJunior;
        	teachSubj1.Subject__c = subjInsJr.Id;
        	teachSubj1.Teacher__c = teacherIns.Id;
        	teachSubj1.Section__c = sectionJr.Id;
        	insert teachSubj1;
        
        	// create teacher subject senior high
        	Teacher_Subject__c teachSubj2 = new Teacher_Subject__c();
        	teachSubj2.RecordTypeId = teachSubjSenior;
        	teachSubj2.Subject__c = subjInsSr12.Id;
        	teachSubj2.Teacher__c = teacherIns.Id;
        	teachSubj2.Semester__c = firstSem.Id;
        	insert teachSubj2;
        	
        
        
            //create enrollment Jr
            
            Student_Year_Semester__c juniorEnrollment = new Student_Year_Semester__c();
            juniorEnrollment.Year__c = yearLevelJunior.Id;
            juniorEnrollment.Student__c = studInsert.Id;
            juniorEnrollment.Section__c = sectionJr.Id;
            juniorEnrollment.recordTypeId = enrollmentJunior;
            insert juniorEnrollment;
        
            checkRecursive.run = true;
            //create enrollment Sr
   			    system.debug('##senior record type id is:'+enrollmentSenior);
                Student_Year_Semester__c srEnrollment = new Student_Year_Semester__c();
                srEnrollment.Year__c = yearLevelSeniorGrade12.Id;
                srEnrollment.Student__c = studInsert.Id;
                srEnrollment.Section__c = sectionSrG12.Id;
                srEnrollment.recordTypeId = enrollmentSenior;
                srEnrollment.Semester__c = firstSem.Id;
                insert srEnrollment;
        

            checkRecursive.run = true;
            //update senior enrollment to G12
            system.debug('** second section name:'+sectionJr2.Name +'year:'+sectionJr2.Year__r.Name);
            system.debug('** firs section name:'+sectionJr.Name +'year:'+sectionJr.Year__r.Name);
        	
            juniorEnrollment.Section__c = sectionJr2.Id;
            update juniorEnrollment;
    	

            
        Test.stopTest();
    }
  
}