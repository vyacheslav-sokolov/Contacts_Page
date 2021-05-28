trigger ContactTrigger on Contact (after insert) {
    if (Trigger.isInsert) {
        List<Case> newCaseList = new List<Case>();

        for(Contact con : Trigger.new) {
            Case newCase = new Case();
            if (con.Contact_Level__c == 'Primary') {
                newCase.Priority = 'High';
            } else if (con.Contact_Level__c == 'Secondary') {
                newCase.Priority = 'Medium';
            } else if (con.Contact_Level__c == 'Tertiary') {
                newCase.Priority = 'Low';
            }
            
            newCase.Status = 'Working';
            newCase.Origin = 'New Contact';
            newCase.ContactId = con.Id;
            
            if (con.AccountId != null) {
                newCase.AccountId = con.AccountId;
            }
            newCaseList.add(newCase);
        }
        insert newCaseList;
    }
}