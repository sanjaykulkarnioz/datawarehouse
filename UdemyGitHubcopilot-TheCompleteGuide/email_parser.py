import os
import email

# this file will handle the parsing of the email

def parse_email(file_path, mode='r'):
    """
    Parses an email file and prints its headers and body.
    Args:
        file_path (str): The path to the email file to be parsed.
        mode (str, optional): The mode in which to open the file. Defaults to 'r'.
    Prints:
        The 'From', 'To', and 'Subject' headers of the email.
        The plain text body of the email if it is multipart, otherwise the entire payload.
    """
    with open(file_path, mode) as file:
        msg = email.message_from_file(file)

        # access email headers
        print("From:", msg['From'])  
        # sender's email
        print("To:", msg['To'])
        print("Subject:", msg['Subject'])

        # access email body
        if msg.is_multipart():
            for part in msg.walk():
                if part.get_content_type() == "text/plain":
                    print(part.get_payload())  
        else:
            print(msg.get_payload())
    
    parse_email("email.eml")
