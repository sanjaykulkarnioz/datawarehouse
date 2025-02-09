import { checkPassword } from "./PasswordChecker";

describe('checkPassword', () => {
    test('throws an error if the password is not a string', () => {
        expect(() => checkPassword(12345678)).toThrow('Password must be a string');
    });

    test('throws an error if the password is less than 8 characters long', () => {
        expect(() => checkPassword('1234567')).toThrow('Password must be at least 8 characters long');
    });

    test('throws an error if the password is more than 20 characters long', () => {
        expect(() => checkPassword('123456789012345678901')).toThrow('Password must be at most 20 characters long');
    });

    test('throws an error if the password does not contain at least one lowercase letter', () => {
        expect(() => checkPassword('12345678')).toThrow('Password must contain at least one lowercase letter');
    });

    test('throws an error if the password does not contain at least one uppercase letter', () => {
        expect(() => checkPassword('12345678')).toThrow('Password must contain at least one uppercase letter');
    });

    test('throws an error if the password does not contain at least one digit', () => {
        expect(() => checkPassword('abcdefgh')).toThrow('Password must contain at least one digit');
    });

    test('throws an error if the password does not contain at least one special character', () => {
        expect(() => checkPassword('Abcdefgh')).toThrow('Password must contain at least one special character');
    });

    test('does not throw an error if the password meets all the criteria', () => {
        expect(() => checkPassword('A1b2c3d4!')).not.toThrow();
    });
}

