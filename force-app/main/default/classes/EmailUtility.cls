public class EmailUtility {
    public static void sendSimpleEmail(List<String> recipientList, String subject, String emailBody){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(recipientList);
        email.setSubject(subject);
        email.setPlainTextBody(emailBody);
        email.setHtmlBody(emailBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }

}