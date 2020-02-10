/**************************************************************************************************
* Name             : EnrollmentTriggerHelper                                                  
* Test Class       : EnrollmentTriggerHelper
* Version          : 1.0                                        
* Function         : Auto Create Subject and Grades                                
* ------------------------------------------------------------------------------------------------ 
* Change History    AUTHOR            DATE                Description                          
* CH00              Jose              24/03/2017                     

***************************************************************************************************/
public class EnrollmentTriggerHelper {


    public static void afterInsertHandler( List<Student_Year_Semester__c> newRecords ) { 
        
        List<Id> yearId = new List<Id>();
        Set<Id> sectionId = new Set<Id>();
        List<Id> semesterId = new List<Id>();
        Map<Id,Id> studentMap = new Map<Id,Id>();
        Map<Id,Student_Year_Semester__c> studentEnrollMap = new Map<Id,Student_Year_Semester__c>();
        String levelRecordType;
            
        List<Student_Subject_Grade__c> listSubjGrade = new List<Student_Subject_Grade__c>(); 
        for(Student_Year_Semester__c studYearSem: newRecords){
            yearId.add(studYearSem.Year__c);
            sectionId.add(studYearSem.Section__c);
            semesterId.add(studYearSem.Semester__c);
            studentMap.put(studYearSem.Id,StudYearSem.Student__c);
            studentEnrollMap.put(studYearSem.Id,studYearSem);
            levelRecordType = Schema.SObjectType.Student_Year_Semester__c.getRecordTypeInfosById().get(studYearSem.recordtypeid).getname();
        
            
        }
        system.debug('##record type is:'+levelRecordType);
        if(levelRecordType == 'Junior Highschool'){
            List<Teacher_Subject__c> listSubject = [SELECT Id,Subject__c,Section__c, Teacher__c FROM Teacher_Subject__c WHERE Subject__r.Active__c = true AND Section__c in: sectionId];
            
              for(Id enrollId: studentEnrollMap.keySet()){
                  
                  for(Teacher_Subject__c subj: listSubject){
                      if(studentEnrollMap.get(enrollId).Section__c == subj.Section__c){
                         Student_Subject_Grade__c studSubjGrade = new Student_Subject_Grade__c();
                         studSubjGrade.Student_Year_Semester__c = enrollId; 
                 //        studSubjGrade.Subject__c = subj.Subject__c;
                 //        studSubjGrade.Teacher__c = subj.Teacher__c;
                         studSubjGrade.Teacher_Subject__c = subj.id;
                         studSubjGrade.Final_Rating__c = 0;
                         studSubjGrade.Student__c = studentEnrollMap.get(enrollId).Student__c;
                         listSubjGrade.add(studSubjGrade);
                      }
              
              	}
              }
      
              if(!listSubjGrade.isEmpty()){
                    insert listSubjGrade;
              }
        }
        
       if(levelRecordType == 'Senior Highschool'){
            system.debug('##entered here at senior highschool');
           
          List<Teacher_Subject__c> listSubject = [SELECT Id,Subject__c,Teacher__c,Semester__c FROM Teacher_Subject__c WHERE Subject__r.Active__c = true AND Semester__c in: semesterId ];
         
           
             for(Id enrollId: studentEnrollMap.keySet()){
                  
                  for(Teacher_Subject__c subj: listSubject){
                      if(studentEnrollMap.get(enrollId).Semester__c == subj.Semester__c){
                         Student_Subject_Grade__c studSubjGrade = new Student_Subject_Grade__c();
                         studSubjGrade.Student_Year_Semester__c = enrollId; 
                //         studSubjGrade.Subject__c = subj.Subject__c;
                //         studSubjGrade.Teacher__c = subj.Teacher__c;
                           studSubjGrade.Final_Rating__c = 0;
                          studSubjGrade.Teacher_Subject__c = subj.id;
                //         studSubjGrade.Semester__c = subj.Semester__c;
                         studSubjGrade.Student__c = studentEnrollMap.get(enrollId).Student__c;
                         listSubjGrade.add(studSubjGrade);
                      }
              
              	}
              }
                
              if(!listSubjGrade.isEmpty()){
                    insert listSubjGrade;
              }
        }
        
        
    }
    
    public static void afterUpdateHandler( List<Student_Year_Semester__c> newRecords, MAP<Id, Student_Year_Semester__c> newRecordMap,MAP<Id, Student_Year_Semester__c> oldRecordMap ) { 
        
        List<Id> studYearSemIds = new List<Id>(); 
        List<Student_Year_Semester__c> studYearSemNew = new List<Student_Year_Semester__c>();
        
        for(Student_Year_Semester__c studYearSem: newRecords){
            studYearSemIds.add(studYearSem.Id);
        }
        
        List<Student_Subject_Grade__c> deleteStudentSubjGrade = [SELECT Id FROM Student_Subject_Grade__c WHERE Student_Year_Semester__c in: studYearSemIds];
                
        
        for(Student_Year_Semester__c studYearSem: newRecords){
           
      //      if( (oldRecordMap.get( studYearSem.Id ).Year__c != newRecordMap.get( studYearSem.Id ).Year__c) || (oldRecordMap.get( studYearSem.Id ).Section__c != newRecordMap.get( studYearSem.Id ).Section__c) || (oldRecordMap.get( studYearSem.Id ).Semester__c != newRecordMap.get( studYearSem.Id ).Semester__c) ){
                studYearSemNew = newRecords; 
                
      //      }
            
        }
        
        if(!studYearSemNew.isEmpty()){
            if(!deleteStudentSubjGrade.isEmpty()){
                Delete deleteStudentSubjGrade;
            }
            afterInsertHandler(studYearSemNew); 
            
        }
       
 
        
    }
   
    
}