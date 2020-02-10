trigger EnrollmentTrigger on Student_Year_Semester__c (after insert, after update) {
 
 	if ( Trigger.isInsert && checkRecursive.runOnce()) {
        EnrollmentTriggerHelper.afterInsertHandler( Trigger.new );
    }

    if ( Trigger.isUpdate && (checkRecursive.runOnce())) {
        EnrollmentTriggerHelper.afterUpdateHandler( Trigger.new,Trigger.newMAP,Trigger.oldMAP );
    }

}