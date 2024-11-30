import fs from 'fs';
import { simpleParser } from 'mailparser';

const fs = require('fs');
const { simpleParser } = require('mailparser');


fs.readFile('path/to/email.eml', (err, data) => {
    if (err) throw err;
    fs.readFile('path/to/email.eml', (err, data) => {
        if (err) throw err;
        simpleParser(data, (err, parsed) => {
            if (err) throw err;
            console.log(parsed);
        });
    });
});