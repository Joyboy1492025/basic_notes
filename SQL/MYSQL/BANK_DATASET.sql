-- ============================================================
--  CREATE BANKING DATABASE 
-- ============================================================

-- CREATE AND USE THE DATABASE
CREATE DATABASE IF NOT EXISTS banking;
USE banking;

-- ============================================================
--  BANKING DATABASE = DROP TABLES
--  Tables: customer | account | transaction | beneficiary 
-- ============================================================

-- DROP TABLES IN REVERSE ORDER OF DEPENDENCIES (to avoid foreign key constraint errors)
DROP TABLE IF EXISTS beneficiary;
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS customer;

-- ============================================================
--  BANKING DATABASE = CREATE TABLES
--  Tables: customer | account | transaction | beneficiary 
-- ============================================================

-- 1. CREATE CUSTOMER TABLE
CREATE TABLE IF NOT EXISTS customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100),
    contact VARCHAR(100) NOT NULL,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL -- Removed UNIQUE (multiple users can share a password) and increased length for hashing
);

-- 2. CREATE ACCOUNT TABLE
CREATE TABLE IF NOT EXISTS account (
    account_id INT PRIMARY KEY,
    customer_id INT,
    type VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL, -- Changed FLOAT to DECIMAL for accurate financial/currency data
    CONSTRAINT fk_account_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

-- 3. CREATE TRANSACTION TABLE
CREATE TABLE IF NOT EXISTS transaction (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    type VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL, -- Changed FLOAT to DECIMAL
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transaction_account FOREIGN KEY (account_id) REFERENCES account(account_id) ON DELETE CASCADE
);

-- 4. CREATE BENEFICIARY TABLE
CREATE TABLE IF NOT EXISTS beneficiary (
    beneficiary_id INT PRIMARY KEY, -- Renamed to beneficiary_id for clarity
    customer_id INT,
    name VARCHAR(50) NOT NULL,
    accountNumber VARCHAR(50) NOT NULL, -- Changed from INT to VARCHAR because account numbers can have leading zeros or be very long
    bankDetails VARCHAR(255),
    CONSTRAINT fk_beneficiary_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);



-- ============================================================
--  BANKING DATABASE 
--  Tables: customer (120) | account (180) | transaction (300+) | beneficiary (120)
-- ============================================================

USE banking;

-- ---------------------------------------------------------------
-- 1. CUSTOMERS  (120 rows)
-- ---------------------------------------------------------------
INSERT INTO customer (customer_id, name, address, contact, username, password) VALUES
(1,  'Aarav Sharma',      '12 MG Road, Mumbai',            '9876543210', 'aarav.sharma',    '$2b$12$KIXv1kQwE1z5aJfOh9NzJO'),
(2,  'Priya Patel',       '45 Brigade Road, Bengaluru',    '9812345678', 'priya.patel',     '$2b$12$LMNv2lRxF2a6bKgPi0OaKP'),
(3,  'Rohan Mehta',       '7 Park Street, Kolkata',        '9823456789', 'rohan.mehta',     '$2b$12$MNOv3mSyG3b7cLhQj1PbLQ'),
(4,  'Sneha Reddy',       '22 Jubilee Hills, Hyderabad',   '9834567890', 'sneha.reddy',     '$2b$12$NOPv4nTzH4c8dMiRk2QcMR'),
(5,  'Vikram Singh',      '89 Civil Lines, Delhi',         '9845678901', 'vikram.singh',    '$2b$12$OPQv5oUaI5d9eNjSl3RdNS'),
(6,  'Ananya Iyer',       '3 Anna Nagar, Chennai',         '9856789012', 'ananya.iyer',     '$2b$12$PQRv6pVbJ6e0fOkTm4SeTT'),
(7,  'Karan Malhotra',    '56 Sector 17, Chandigarh',      '9867890123', 'karan.malhotra',  '$2b$12$QRSv7qWcK7f1gPlUn5TfUU'),
(8,  'Divya Nair',        '14 Residency Road, Pune',       '9878901234', 'divya.nair',      '$2b$12$RST v8rXdL8g2hQmVo6UgVV'),
(9,  'Arjun Kapoor',      '67 Linking Road, Mumbai',       '9889012345', 'arjun.kapoor',    '$2b$12$STUv9sYeM9h3iRnWp7VhWW'),
(10, 'Meera Joshi',       '33 FC Road, Pune',              '9890123456', 'meera.joshi',     '$2b$12$TUVv0tZfN0i4jSoXq8WiXX'),
(11, 'Rahul Gupta',       '11 Connaught Place, Delhi',     '9801234567', 'rahul.gupta',     '$2b$12$UVWv1uAgO1j5kTpYr9XjYY'),
(12, 'Kavya Krishnan',    '78 Koramangala, Bengaluru',     '9712345678', 'kavya.krishnan',  '$2b$12$VWXv2vBhP2k6lUqZs0YkZZ'),
(13, 'Amit Verma',        '5 Hazratganj, Lucknow',         '9723456789', 'amit.verma',      '$2b$12$WXYv3wCiQ3l7mVrAt1ZlAA'),
(14, 'Pooja Tiwari',      '29 Banjara Hills, Hyderabad',   '9734567890', 'pooja.tiwari',    '$2b$12$XYZv4xDjR4m8nWsBu2AmBB'),
(15, 'Siddharth Rao',     '44 T Nagar, Chennai',           '9745678901', 'siddharth.rao',   '$2b$12$YZAv5yEkS5n9oXtCv3BnCC'),
(16, 'Neha Bansal',       '18 Model Town, Delhi',          '9756789012', 'neha.bansal',     '$2b$12$ZABv6zFlT6o0pYuDw4CoDD'),
(17, 'Gaurav Mishra',     '62 Gomti Nagar, Lucknow',       '9767890123', 'gaurav.mishra',   '$2b$12$ABCv7aGmU7p1qZvEx5DpEE'),
(18, 'Sunita Pillai',     '9 Vile Parle, Mumbai',          '9778901234', 'sunita.pillai',   '$2b$12$BCDv8bHnV8q2rAwFy6EqFF'),
(19, 'Nikhil Choudhary',  '37 Salt Lake, Kolkata',         '9789012345', 'nikhil.choudhary','$2b$12$CDEv9cIoW9r3sBxGz7FrGG'),
(20, 'Ritu Aggarwal',     '53 Panchkula, Chandigarh',      '9790123456', 'ritu.aggarwal',   '$2b$12$DEFv0dJpX0s4tCyH08GsHH'),
(21, 'Manish Kumar',      '21 Ashok Nagar, Bhopal',        '9611234567', 'manish.kumar',    '$2b$12$EFGv1eKqY1t5uDzI19HtII'),
(22, 'Shruti Desai',      '46 Navrangpura, Ahmedabad',     '9622345678', 'shruti.desai',    '$2b$12$FGHv2fLrZ2u6vEaJ20IuJJ'),
(23, 'Deepak Pandey',     '8 Lal Bagh, Lucknow',           '9633456789', 'deepak.pandey',   '$2b$12$GHIv3gMsA3v7wFbK31JvKK'),
(24, 'Priyanka Saxena',   '74 Vaishali Nagar, Jaipur',     '9644567890', 'priyanka.saxena', '$2b$12$HIJv4hNtB4w8xGcL42KwLL'),
(25, 'Suresh Naik',       '30 Margao, Goa',                '9655678901', 'suresh.naik',     '$2b$12$IJKv5iOuC5x9yHdM53LxMM'),
(26, 'Anjali Bose',       '16 Bhawanipur, Kolkata',        '9666789012', 'anjali.bose',     '$2b$12$JKLv6jPvD6y0zIeN64MyNN'),
(27, 'Rajesh Patil',      '58 Deccan, Pune',               '9677890123', 'rajesh.patil',    '$2b$12$KLMv7kQwE7z1aJfO75NzOO'),
(28, 'Swati Ghosh',       '2 Ballygunge, Kolkata',         '9688901234', 'swati.ghosh',     '$2b$12$LMNv8lRxF8a2bKgP86OaPP'),
(29, 'Tarun Jain',        '40 Malviya Nagar, Delhi',       '9699012345', 'tarun.jain',      '$2b$12$MNOv9mSyG9b3cLhQ97PbQQ'),
(30, 'Pallavi Deshpande', '25 Sadashiv Peth, Pune',        '9600123456', 'pallavi.d',       '$2b$12$NOPv0nTzH0c4dMiR08QcRR'),
(31, 'Aditya Srivastava', '13 Hazratganj, Lucknow',        '9511234567', 'aditya.srivas',   '$2b$12$OPQv1oUaI1d5eNjS19RdSS'),
(32, 'Kirti Menon',       '61 Thiruvanmiyur, Chennai',     '9522345678', 'kirti.menon',     '$2b$12$PQRv2pVbJ2e6fOkT20SeTT'),
(33, 'Vivek Chauhan',     '77 Rajpur Road, Dehradun',      '9533456789', 'vivek.chauhan',   '$2b$12$QRSv3qWcK3f7gPlU31TfUU'),
(34, 'Shweta Kulkarni',   '35 Bavdhan, Pune',              '9544567890', 'shweta.kulkarni', '$2b$12$RST v4rXdL4g8hQmV42UgVV'),
(35, 'Mohit Arora',       '19 Sarojini Nagar, Delhi',      '9555678901', 'mohit.arora',     '$2b$12$STUv5sYeM5h9iRnW53VhWW'),
(36, 'Ishaan Bhat',       '88 Indiranagar, Bengaluru',     '9566789012', 'ishaan.bhat',     '$2b$12$TUVv6tZfN6i0jSoX64WiXX'),
(37, 'Komal Shah',        '6 Navrangpura, Ahmedabad',      '9577890123', 'komal.shah',      '$2b$12$UVWv7uAgO7j1kTpY75XjYY'),
(38, 'Neeraj Tomar',      '50 Sector 22, Noida',           '9588901234', 'neeraj.tomar',    '$2b$12$VWXv8vBhP8k2lUqZ86YkZZ'),
(39, 'Rekha Nambiar',     '23 Kalamassery, Kochi',         '9599012345', 'rekha.nambiar',   '$2b$12$WXYv9wCiQ9l3mVrA97ZlAA'),
(40, 'Saurabh Dubey',     '48 Tilak Nagar, Delhi',         '9500123456', 'saurabh.dubey',   '$2b$12$XYZv0xDjR0m4nWsB08AmBB'),
(41, 'Tanvi Hegde',       '71 JP Nagar, Bengaluru',        '9411234567', 'tanvi.hegde',     '$2b$12$YZAv1yEkS1n5oXtC19BnCC'),
(42, 'Chirag Patel',      '15 Satellite, Ahmedabad',       '9422345678', 'chirag.patel',    '$2b$12$ZABv2zFlT2o6pYuD20CoDD'),
(43, 'Divyanka Tripathi', '39 Varanasi Cantonment',        '9433456789', 'divyanka.t',      '$2b$12$ABCv3aGmU3p7qZvE31DpEE'),
(44, 'Harsh Vardhan',     '64 Sector 14, Faridabad',       '9444567890', 'harsh.vardhan',   '$2b$12$BCDv4bHnV4q8rAwF42EqFF'),
(45, 'Lavanya Suresh',    '28 Mylapore, Chennai',          '9455678901', 'lavanya.suresh',  '$2b$12$CDEv5cIoW5r9sBxG53FrGG'),
(46, 'Mayank Joshi',      '43 Arera Colony, Bhopal',       '9466789012', 'mayank.joshi',    '$2b$12$DEFv6dJpX6s0tCyH64GsHH'),
(47, 'Nandini Kaur',      '20 Sector 8, Chandigarh',       '9477890123', 'nandini.kaur',    '$2b$12$EFGv7eKqY7t1uDzI75HtII'),
(48, 'Om Prakash Yadav',  '55 Gorakhpur Station Road',     '9488901234', 'om.yadav',        '$2b$12$FGHv8fLrZ8u2vEaJ86IuJJ'),
(49, 'Prerna Sinha',      '31 Kidwai Nagar, Kanpur',       '9499012345', 'prerna.sinha',    '$2b$12$GHIv9gMsA9v3wFbK97JvKK'),
(50, 'Qutub Ansari',      '17 Fraser Road, Patna',         '9400123456', 'qutub.ansari',    '$2b$12$HIJv0hNtB0w4xGcL08KwLL'),
(51, 'Rohini Devi',       '72 Rajendra Nagar, Hyderabad',  '9311234567', 'rohini.devi',     '$2b$12$IJKv1iOuC1x5yHdM19LxMM'),
(52, 'Sameer Khan',       '4 Byculla, Mumbai',             '9322345678', 'sameer.khan',     '$2b$12$JKLv2jPvD2y6zIeN20MyNN'),
(53, 'Tara Pillai',       '68 Thampanoor, Thiruvananthapuram','9333456789','tara.pillai',    '$2b$12$KLMv3kQwE3z7aJfO31NzOO'),
(54, 'Uday Shankar',      '27 Puri Beach Road, Bhubaneswar','9344567890', 'uday.shankar',   '$2b$12$LMNv4lRxF4a8bKgP42OaPP'),
(55, 'Vaishali Mane',     '83 Hadapsar, Pune',             '9355678901', 'vaishali.mane',   '$2b$12$MNOv5mSyG5b9cLhQ53PbQQ'),
(56, 'Wasim Sheikh',      '10 Zakir Hussain Road, Delhi',  '9366789012', 'wasim.sheikh',    '$2b$12$NOPv6nTzH6c0dMiR64QcRR'),
(57, 'Xena Thomas',       '36 Edappally, Kochi',           '9377890123', 'xena.thomas',     '$2b$12$OPQv7oUaI7d1eNjS75RdSS'),
(58, 'Yashpal Rathore',   '52 Vaishali Nagar, Jaipur',     '9388901234', 'yashpal.rathore', '$2b$12$PQRv8pVbJ8e2fOkT86SeTT'),
(59, 'Zara Hussain',      '26 Shivaji Nagar, Pune',        '9399012345', 'zara.hussain',    '$2b$12$QRSv9qWcK9f3gPlU97TfUU'),
(60, 'Abhishek Tiwari',   '59 Gomti Nagar, Lucknow',       '9300123456', 'abhishek.tiwari', '$2b$12$RST v0rXdL0g4hQmV08UgVV'),
(61, 'Bhavna Mittal',     '14 Kirti Nagar, Delhi',         '9211234567', 'bhavna.mittal',   '$2b$12$STUv1sYeM1h5iRnW19VhWW'),
(62, 'Chetan Khatri',     '49 Girnar Colony, Ahmedabad',   '9222345678', 'chetan.khatri',   '$2b$12$TUVv2tZfN2i6jSoX20WiXX'),
(63, 'Deeksha Bajaj',     '73 Green Park, Delhi',          '9233456789', 'deeksha.bajaj',   '$2b$12$UVWv3uAgO3j7kTpY31XjYY'),
(64, 'Ekta Soni',         '38 Sindhi Colony, Nagpur',      '9244567890', 'ekta.soni',       '$2b$12$VWXv4vBhP4k8lUqZ42YkZZ'),
(65, 'Farhan Qureshi',    '12 Abids, Hyderabad',           '9255678901', 'farhan.qureshi',  '$2b$12$WXYv5wCiQ5l9mVrA53ZlAA'),
(66, 'Geeta Nair',        '57 Kakkanad, Kochi',            '9266789012', 'geeta.nair',      '$2b$12$XYZv6xDjR6m0nWsB64AmBB'),
(67, 'Hemant Dixit',      '34 Laxmi Nagar, Delhi',         '9277890123', 'hemant.dixit',    '$2b$12$YZAv7yEkS7n1oXtC75BnCC'),
(68, 'Isha Chadha',       '80 Palam Vihar, Gurugram',      '9288901234', 'isha.chadha',     '$2b$12$ZABv8zFlT8o2pYuD86CoDD'),
(69, 'Jatin Sethi',       '42 Haibowal, Ludhiana',         '9299012345', 'jatin.sethi',     '$2b$12$ABCv9aGmU9p3qZvE97DpEE'),
(70, 'Kamakshi Venkatesan','18 Thiruporur, Chennai',       '9200123456', 'kamakshi.v',      '$2b$12$BCDv0bHnV0q4rAwF08EqFF'),
(71, 'Lokesh Pandey',     '63 Boring Road, Patna',         '9111234567', 'lokesh.pandey',   '$2b$12$CDEv1cIoW1r5sBxG19FrGG'),
(72, 'Madhuri Shetty',    '29 Mangalore Port Area',        '9122345678', 'madhuri.shetty',  '$2b$12$DEFv2dJpX2s6tCyH20GsHH'),
(73, 'Navin Trivedi',     '75 Paldi, Ahmedabad',           '9133456789', 'navin.trivedi',   '$2b$12$EFGv3eKqY3t7uDzI31HtII'),
(74, 'Ojasvi Rawat',      '41 Rajpur Road, Dehradun',      '9144567890', 'ojasvi.rawat',    '$2b$12$FGHv4fLrZ4u8vEaJ42IuJJ'),
(75, 'Prakash Rao',       '66 Ameerpet, Hyderabad',        '9155678901', 'prakash.rao',     '$2b$12$GHIv5gMsA5v9wFbK53JvKK'),
(76, 'Qamar Fatima',      '22 Charminar, Hyderabad',       '9166789012', 'qamar.fatima',    '$2b$12$HIJv6hNtB6w0xGcL64KwLL'),
(77, 'Raveena Tandon',    '37 Versova, Mumbai',            '9177890123', 'raveena.tandon',  '$2b$12$IJKv7iOuC7x1yHdM75LxMM'),
(78, 'Sourav Mondal',     '5 Rabindra Sarani, Kolkata',    '9188901234', 'sourav.mondal',   '$2b$12$JKLv8jPvD8y2zIeN86MyNN'),
(79, 'Trisha Mukherjee',  '47 Lake Town, Kolkata',         '9199012345', 'trisha.m',        '$2b$12$KLMv9kQwE9z3aJfO97NzOO'),
(80, 'Ujjwal Sood',       '60 Lawrence Road, Amritsar',    '9100123456', 'ujjwal.sood',     '$2b$12$LMNv0lRxF0a4bKgP08OaPP'),
(81, 'Vrinda Rastogi',    '16 Lajpat Nagar, Delhi',        '8911234567', 'vrinda.rastogi',  '$2b$12$MNOv1mSyG1b5cLhQ19PbQQ'),
(82, 'Waqar Ahmed',       '32 Koti, Hyderabad',            '8922345678', 'waqar.ahmed',     '$2b$12$NOPv2nTzH2c6dMiR20QcRR'),
(83, 'Xenia D''Souza',    '54 Panjim, Goa',                '8933456789', 'xenia.dsouza',    '$2b$12$OPQv3oUaI3d7eNjS31RdSS'),
(84, 'Yogesh Garg',       '78 Pitampura, Delhi',           '8944567890', 'yogesh.garg',     '$2b$12$PQRv4pVbJ4e8fOkT42SeTT'),
(85, 'Zeena Krishnaswamy','23 Coimbatore RS',              '8955678901', 'zeena.k',         '$2b$12$QRSv5qWcK5f9gPlU53TfUU'),
(86, 'Anand Venkataraman','69 Adyar, Chennai',             '8966789012', 'anand.v',         '$2b$12$RST v6rXdL6g0hQmV64UgVV'),
(87, 'Bhumi Pednekar',    '8 Andheri East, Mumbai',        '8977890123', 'bhumi.p',         '$2b$12$STUv7sYeM7h1iRnW75VhWW'),
(88, 'Chandrashekhar Azad','43 Indore Bypass Road',        '8988901234', 'chandra.azad',    '$2b$12$TUVv8tZfN8i2jSoX86WiXX'),
(89, 'Daksha Parmar',     '61 Sola, Ahmedabad',            '8999012345', 'daksha.parmar',   '$2b$12$UVWv9uAgO9j3kTpY97XjYY'),
(90, 'Eshan Malviya',     '27 Vijay Nagar, Indore',        '8900123456', 'eshan.malviya',   '$2b$12$VWXv0vBhP0k4lUqZ08YkZZ'),
(91, 'Falguni Pathak',    '50 Navrangpura, Ahmedabad',     '8811234567', 'falguni.p',       '$2b$12$WXYv1wCiQ1l5mVrA19ZlAA'),
(92, 'Girish Karnad',     '15 Jayanagar, Bengaluru',       '8822345678', 'girish.karnad',   '$2b$12$XYZv2xDjR2m6nWsB20AmBB'),
(93, 'Hemlata Pant',      '39 Kashipur Road, Rudrapur',    '8833456789', 'hemlata.pant',    '$2b$12$YZAv3yEkS3n7oXtC31BnCC'),
(94, 'Ishan Khatter',     '74 Versova, Mumbai',            '8844567890', 'ishan.khatter',   '$2b$12$ZABv4zFlT4o8pYuD42CoDD'),
(95, 'Jasmin Bhasin',     '28 Zirakpur, Chandigarh',       '8855678901', 'jasmin.bhasin',   '$2b$12$ABCv5aGmU5p9qZvE53DpEE'),
(96, 'Kuldeep Yadav',     '45 Saket, Delhi',               '8866789012', 'kuldeep.yadav',   '$2b$12$BCDv6bHnV6q0rAwF64EqFF'),
(97, 'Lata Mangeshkar',   '19 Pedder Road, Mumbai',        '8877890123', 'lata.m',          '$2b$12$CDEv7cIoW7r1sBxG75FrGG'),
(98, 'Mihir Desai',       '55 Satellite, Ahmedabad',       '8888901234', 'mihir.desai',     '$2b$12$DEFv8dJpX8s2tCyH86GsHH'),
(99, 'Nita Ambani',       '23 Cuffe Parade, Mumbai',       '8899012345', 'nita.a',          '$2b$12$EFGv9eKqY9t3uDzI97HtII'),
(100,'Om Shanti Das',     '68 Salt Lake, Kolkata',         '8800123456', 'om.shanti',       '$2b$12$FGHv0fLrZ0u4vEaJ08IuJJ'),
(101,'Padmavathi Rajan',  '34 Tirunelveli Junction',       '8711234567', 'padmavathi.r',    '$2b$12$GHIv1gMsA1v5wFbK19JvKK'),
(102,'Quresh Momin',      '7 Nagpada, Mumbai',             '8722345678', 'quresh.momin',    '$2b$12$HIJv2hNtB2w6xGcL20KwLL'),
(103,'Ramdas Athavale',   '52 Dadar, Mumbai',              '8733456789', 'ramdas.a',        '$2b$12$IJKv3iOuC3x7yHdM31LxMM'),
(104,'Sarla Bhosle',      '76 Tilak Road, Pune',           '8744567890', 'sarla.bhosle',    '$2b$12$JKLv4jPvD4y8zIeN42MyNN'),
(105,'Tejas Menon',       '31 Edappal, Kerala',            '8755678901', 'tejas.menon',     '$2b$12$KLMv5kQwE5z9aJfO53NzOO'),
(106,'Uma Shankar Gupta', '48 Allahabad Civil Lines',      '8766789012', 'uma.gupta',       '$2b$12$LMNv6lRxF6a0bKgP64OaPP'),
(107,'Veer Pahariya',     '64 Sector 5, Dwarka, Delhi',    '8777890123', 'veer.p',          '$2b$12$MNOv7mSyG7b1cLhQ75PbQQ'),
(108,'Wriddhiman Saha',   '20 Hooghly, Kolkata',           '8788901234', 'wriddhiman.s',    '$2b$12$NOPv8nTzH8c2dMiR86QcRR'),
(109,'Xander Fernandes',  '38 Margao, Goa',                '8799012345', 'xander.f',        '$2b$12$OPQv9oUaI9d3eNjS97RdSS'),
(110,'Yamini Krishnan',   '55 Adyar, Chennai',             '8700123456', 'yamini.k',        '$2b$12$PQRv0pVbJ0e4fOkT08SeTT'),
(111,'Zubair Siddiqui',   '11 Jama Masjid, Delhi',         '8611234567', 'zubair.s',        '$2b$12$QRSv1qWcK1f5gPlU19TfUU'),
(112,'Aruna Iyer',        '67 Besant Nagar, Chennai',      '8622345678', 'aruna.iyer',      '$2b$12$RST v2rXdL2g6hQmV20UgVV'),
(113,'Brijesh Sinha',     '44 Bailey Road, Patna',         '8633456789', 'brijesh.sinha',   '$2b$12$STUv3sYeM3h7iRnW31VhWW'),
(114,'Charu Sharma',      '29 Maharani Bagh, Delhi',       '8644567890', 'charu.sharma',    '$2b$12$TUVv4tZfN4i8jSoX42WiXX'),
(115,'Devraj Nair',       '82 Thrissur Round',             '8655678901', 'devraj.nair',     '$2b$12$UVWv5uAgO5j9kTpY53XjYY'),
(116,'Eshaan Qazi',       '36 Srinagar Boulevard',         '8666789012', 'eshaan.qazi',     '$2b$12$VWXv6vBhP6k0lUqZ64YkZZ'),
(117,'Fiona D''Costa',    '17 Panaji, Goa',                '8677890123', 'fiona.dcosta',    '$2b$12$WXYv7wCiQ7l1mVrA75ZlAA'),
(118,'Govind Swami',      '53 Pushkar Road, Ajmer',        '8688901234', 'govind.swami',    '$2b$12$XYZv8xDjR8m2nWsB86AmBB'),
(119,'Harshita Agarwal',  '41 Vasundhra, Ghaziabad',       '8699012345', 'harshita.a',      '$2b$12$YZAv9yEkS9n3oXtC97BnCC'),
(120,'Indrani Mukherjee', '60 Ballygunge, Kolkata',        '8600123456', 'indrani.m',       '$2b$12$ZABv0zFlT0o4pYuD08CoDD');

-- ---------------------------------------------------------------
-- 2. ACCOUNTS  (180 rows — some customers have 2 accounts)
-- ---------------------------------------------------------------
INSERT INTO account (account_id, customer_id, type, balance) VALUES
(1001,1,'Savings',45230.50),(1002,1,'Current',120000.00),
(1003,2,'Savings',32100.75),(1004,2,'Fixed Deposit',200000.00),
(1005,3,'Savings',18750.00),(1006,3,'Current',55000.00),
(1007,4,'Savings',67890.25),(1008,4,'Savings',12000.00),
(1009,5,'Current',340000.00),(1010,5,'Savings',23450.75),
(1011,6,'Savings',9800.00),(1012,6,'Fixed Deposit',150000.00),
(1013,7,'Savings',74500.00),(1014,7,'Current',89000.00),
(1015,8,'Savings',31200.50),(1016,8,'Savings',5600.00),
(1017,9,'Current',280000.00),(1018,9,'Savings',41100.25),
(1019,10,'Savings',22300.00),(1020,10,'Fixed Deposit',500000.00),
(1021,11,'Savings',15600.75),(1022,11,'Current',103000.00),
(1023,12,'Savings',58900.00),(1024,12,'Savings',8700.00),
(1025,13,'Current',172000.00),(1026,13,'Savings',33400.50),
(1027,14,'Savings',26700.00),(1028,14,'Fixed Deposit',100000.00),
(1029,15,'Savings',49300.25),(1030,15,'Current',67800.00),
(1031,16,'Savings',11200.00),(1032,16,'Savings',34500.75),
(1033,17,'Current',256000.00),(1034,17,'Savings',17800.00),
(1035,18,'Savings',61200.50),(1036,18,'Fixed Deposit',300000.00),
(1037,19,'Savings',28900.00),(1038,19,'Current',94000.00),
(1039,20,'Savings',37600.25),(1040,20,'Savings',13400.00),
(1041,21,'Current',148000.00),(1042,21,'Savings',52300.75),
(1043,22,'Savings',23100.00),(1044,22,'Fixed Deposit',250000.00),
(1045,23,'Savings',16800.50),(1046,23,'Current',78000.00),
(1047,24,'Savings',71400.00),(1048,24,'Savings',9200.00),
(1049,25,'Current',320000.00),(1050,25,'Savings',44600.25),
(1051,26,'Savings',19300.00),(1052,26,'Fixed Deposit',175000.00),
(1053,27,'Savings',83700.50),(1054,27,'Current',112000.00),
(1055,28,'Savings',27400.00),(1056,28,'Savings',6100.75),
(1057,29,'Current',210000.00),(1058,29,'Savings',38900.00),
(1059,30,'Savings',25600.50),(1060,30,'Fixed Deposit',400000.00),
(1061,31,'Savings',14700.00),(1062,31,'Current',96500.00),
(1063,32,'Savings',62800.25),(1064,32,'Savings',10300.00),
(1065,33,'Current',184000.00),(1066,33,'Savings',35700.50),
(1067,34,'Savings',29100.00),(1068,34,'Fixed Deposit',125000.00),
(1069,35,'Savings',53400.75),(1070,35,'Current',72500.00),
(1071,36,'Savings',12100.00),(1072,36,'Savings',47800.00),
(1073,37,'Current',268000.00),(1074,37,'Savings',21600.25),
(1075,38,'Savings',68300.50),(1076,38,'Fixed Deposit',350000.00),
(1077,39,'Savings',31800.00),(1078,39,'Current',88000.00),
(1079,40,'Savings',42700.25),(1080,40,'Savings',15100.00),
(1081,41,'Current',156000.00),(1082,41,'Savings',57200.75),
(1083,42,'Savings',24500.00),(1084,42,'Fixed Deposit',225000.00),
(1085,43,'Savings',17900.50),(1086,43,'Current',83000.00),
(1087,44,'Savings',76600.00),(1088,44,'Savings',11400.00),
(1089,45,'Current',296000.00),(1090,45,'Savings',48300.25),
(1091,46,'Savings',20700.00),(1092,46,'Fixed Deposit',160000.00),
(1093,47,'Savings',86900.50),(1094,47,'Current',105000.00),
(1095,48,'Savings',29600.00),(1096,48,'Savings',7800.75),
(1097,49,'Current',192000.00),(1098,49,'Savings',40200.00),
(1099,50,'Savings',27800.50),(1100,50,'Fixed Deposit',450000.00),
(1101,51,'Savings',16300.00),(1102,51,'Current',91000.00),
(1103,52,'Savings',65400.25),(1104,52,'Savings',12900.00),
(1105,53,'Current',176000.00),(1106,53,'Savings',38100.50),
(1107,54,'Savings',30500.00),(1108,54,'Fixed Deposit',115000.00),
(1109,55,'Savings',55700.75),(1110,55,'Current',69800.00),
(1111,56,'Savings',13500.00),(1112,56,'Savings',49100.00),
(1113,57,'Current',244000.00),(1114,57,'Savings',22900.25),
(1115,58,'Savings',71600.50),(1116,58,'Fixed Deposit',325000.00),
(1117,59,'Savings',33200.00),(1118,59,'Current',86500.00),
(1119,60,'Savings',44800.25),(1120,60,'Savings',16600.00),
(1121,61,'Current',164000.00),(1122,61,'Savings',60100.75),
(1123,62,'Savings',25900.00),(1124,62,'Fixed Deposit',210000.00),
(1125,63,'Savings',19100.50),(1126,63,'Current',79500.00),
(1127,64,'Savings',79300.00),(1128,64,'Savings',10800.00),
(1129,65,'Current',308000.00),(1130,65,'Savings',50600.25),
(1131,66,'Savings',21900.00),(1132,66,'Fixed Deposit',185000.00),
(1133,67,'Savings',89600.50),(1134,67,'Current',118000.00),
(1135,68,'Savings',32100.00),(1136,68,'Savings',8400.75),
(1137,69,'Current',220000.00),(1138,69,'Savings',43500.00),
(1139,70,'Savings',29000.50),(1140,70,'Fixed Deposit',475000.00),
(1141,71,'Savings',17800.00),(1142,71,'Current',98500.00),
(1143,72,'Savings',68100.25),(1144,72,'Savings',14200.00),
(1145,73,'Current',188000.00),(1146,73,'Savings',40600.50),
(1147,74,'Savings',32900.00),(1148,74,'Fixed Deposit',130000.00),
(1149,75,'Savings',58400.75),(1150,75,'Current',74200.00),
(1151,76,'Savings',14800.00),(1152,76,'Savings',51400.00),
(1153,77,'Current',276000.00),(1154,77,'Savings',24200.25),
(1155,78,'Savings',73900.50),(1156,78,'Fixed Deposit',360000.00),
(1157,79,'Savings',35500.00),(1158,79,'Current',90800.00),
(1159,80,'Savings',46100.25),(1160,80,'Savings',17900.00),
(1161,81,'Current',172000.00),(1162,81,'Savings',63400.75),
(1163,82,'Savings',27200.00),(1164,82,'Fixed Deposit',235000.00),
(1165,83,'Savings',20400.50),(1166,83,'Current',82000.00),
(1167,84,'Savings',82000.00),(1168,84,'Savings',12300.00),
(1169,85,'Current',316000.00),(1170,85,'Savings',53900.25),
(1171,86,'Savings',23200.00),(1172,86,'Fixed Deposit',195000.00),
(1173,87,'Savings',92300.50),(1174,87,'Current',128000.00),
(1175,88,'Savings',34700.00),(1176,88,'Savings',9100.75),
(1177,89,'Current',228000.00),(1178,89,'Savings',46800.00),
(1179,90,'Savings',30300.50),(1180,90,'Fixed Deposit',525000.00);

-- ---------------------------------------------------------------
-- 3. TRANSACTIONS  (350 rows)
-- ---------------------------------------------------------------
INSERT INTO transaction (transaction_id, account_id, type, amount, timestamp) VALUES
-- Account 1001 (Aarav Savings)
(5001,1001,'Credit',50000.00,'2024-01-05 09:15:00'),
(5002,1001,'Debit',4770.50,'2024-01-12 14:30:00'),
(5003,1001,'Credit',25000.00,'2024-02-03 10:00:00'),
(5004,1001,'Debit',24999.00,'2024-02-20 16:45:00'),
-- Account 1002 (Aarav Current)
(5005,1002,'Credit',150000.00,'2024-01-01 08:00:00'),
(5006,1002,'Debit',30000.00,'2024-01-15 11:20:00'),
-- Account 1003 (Priya Savings)
(5007,1003,'Credit',35000.00,'2024-01-08 09:30:00'),
(5008,1003,'Debit',2899.25,'2024-01-25 13:00:00'),
(5009,1003,'Credit',10000.00,'2024-02-10 10:30:00'),
(5010,1003,'Debit',10000.00,'2024-03-01 17:00:00'),
-- Account 1005 (Rohan Savings)
(5011,1005,'Credit',20000.00,'2024-01-10 08:45:00'),
(5012,1005,'Debit',1250.00,'2024-01-22 12:15:00'),
(5013,1005,'Credit',15000.00,'2024-02-14 09:00:00'),
-- Account 1007 (Sneha Savings)
(5014,1007,'Credit',70000.00,'2024-01-03 10:10:00'),
(5015,1007,'Debit',2109.75,'2024-01-18 15:30:00'),
(5016,1007,'Credit',5000.00,'2024-02-07 11:00:00'),
(5017,1007,'Debit',5000.00,'2024-02-28 14:00:00'),
-- Account 1009 (Vikram Current)
(5018,1009,'Credit',400000.00,'2024-01-01 07:30:00'),
(5019,1009,'Debit',60000.00,'2024-01-10 16:00:00'),
(5020,1009,'Debit',40000.00,'2024-02-05 10:30:00'),
(5021,1009,'Credit',40000.00,'2024-03-01 08:00:00'),
-- Account 1011 (Ananya Savings)
(5022,1011,'Credit',10000.00,'2024-01-15 09:00:00'),
(5023,1011,'Debit',200.00,'2024-01-28 14:20:00'),
-- Account 1013 (Karan Savings)
(5024,1013,'Credit',80000.00,'2024-01-07 08:30:00'),
(5025,1013,'Debit',5500.00,'2024-01-23 13:45:00'),
(5026,1013,'Credit',10000.00,'2024-02-18 10:15:00'),
(5027,1013,'Debit',20000.00,'2024-03-05 16:00:00'),
-- Account 1015 (Divya Savings)
(5028,1015,'Credit',33000.00,'2024-01-09 09:20:00'),
(5029,1015,'Debit',1800.50,'2024-01-26 12:00:00'),
(5030,1015,'Credit',5000.00,'2024-02-22 11:30:00'),
-- Account 1017 (Arjun Current)
(5031,1017,'Credit',300000.00,'2024-01-02 08:15:00'),
(5032,1017,'Debit',20000.00,'2024-01-16 17:00:00'),
-- Account 1019 (Meera Savings)
(5033,1019,'Credit',25000.00,'2024-01-11 09:45:00'),
(5034,1019,'Debit',2700.00,'2024-01-27 13:30:00'),
(5035,1019,'Credit',5000.00,'2024-02-16 10:00:00'),
(5036,1019,'Debit',5000.00,'2024-03-03 15:30:00'),
-- Account 1021 (Rahul Savings)
(5037,1021,'Credit',18000.00,'2024-01-14 08:00:00'),
(5038,1021,'Debit',2400.25,'2024-01-29 11:45:00'),
-- Account 1023 (Kavya Savings)
(5039,1023,'Credit',62000.00,'2024-01-06 09:00:00'),
(5040,1023,'Debit',3100.00,'2024-01-21 14:00:00'),
(5041,1023,'Credit',7000.00,'2024-02-12 10:30:00'),
(5042,1023,'Debit',7100.00,'2024-03-08 16:45:00'),
-- Account 1025 (Amit Current)
(5043,1025,'Credit',180000.00,'2024-01-02 07:45:00'),
(5044,1025,'Debit',8000.00,'2024-01-17 15:15:00'),
-- Account 1027 (Pooja Savings)
(5045,1027,'Credit',28000.00,'2024-01-13 09:30:00'),
(5046,1027,'Debit',1300.00,'2024-01-30 12:30:00'),
(5047,1027,'Credit',6000.00,'2024-02-20 11:00:00'),
-- Account 1029 (Siddharth Savings)
(5048,1029,'Credit',52000.00,'2024-01-04 08:45:00'),
(5049,1029,'Debit',2700.75,'2024-01-19 13:15:00'),
(5050,1029,'Credit',8000.00,'2024-02-15 10:00:00'),
(5051,1029,'Debit',8700.00,'2024-03-06 17:30:00'),
-- Account 1031 (Neha Savings)
(5052,1031,'Credit',12000.00,'2024-01-16 09:15:00'),
(5053,1031,'Debit',800.00,'2024-02-01 14:00:00'),
-- Account 1033 (Gaurav Current)
(5054,1033,'Credit',270000.00,'2024-01-03 08:00:00'),
(5055,1033,'Debit',14000.00,'2024-01-18 16:30:00'),
(5056,1033,'Credit',25000.00,'2024-02-10 09:15:00'),
(5057,1033,'Debit',25000.00,'2024-03-01 11:00:00'),
-- Account 1035 (Sunita Savings)
(5058,1035,'Credit',64000.00,'2024-01-08 09:00:00'),
(5059,1035,'Debit',2800.50,'2024-01-24 12:45:00'),
(5060,1035,'Credit',9000.00,'2024-02-19 10:15:00'),
-- Account 1037 (Nikhil Savings)
(5061,1037,'Credit',30000.00,'2024-01-12 08:30:00'),
(5062,1037,'Debit',1100.00,'2024-01-28 13:00:00'),
(5063,1037,'Credit',7000.00,'2024-02-23 11:30:00'),
(5064,1037,'Debit',8100.00,'2024-03-09 15:45:00'),
-- Account 1039 (Ritu Savings)
(5065,1039,'Credit',40000.00,'2024-01-10 09:30:00'),
(5066,1039,'Debit',2400.75,'2024-01-25 14:15:00'),
-- Account 1041 (Manish Current)
(5067,1041,'Credit',155000.00,'2024-01-01 07:45:00'),
(5068,1041,'Debit',7000.00,'2024-01-20 16:00:00'),
(5069,1041,'Credit',12000.00,'2024-02-14 09:30:00'),
-- Account 1043 (Shruti Savings)
(5070,1043,'Credit',25000.00,'2024-01-09 09:00:00'),
(5071,1043,'Debit',1900.00,'2024-01-26 12:30:00'),
(5072,1043,'Credit',5000.00,'2024-02-21 11:00:00'),
(5073,1043,'Debit',6000.00,'2024-03-07 14:30:00'),
-- Account 1045 (Deepak Savings)
(5074,1045,'Credit',18500.00,'2024-01-14 08:15:00'),
(5075,1045,'Debit',1700.50,'2024-01-30 13:45:00'),
-- Account 1047 (Priyanka Savings)
(5076,1047,'Credit',75000.00,'2024-01-05 09:30:00'),
(5077,1047,'Debit',3600.00,'2024-01-20 14:00:00'),
(5078,1047,'Credit',10000.00,'2024-02-17 10:30:00'),
(5079,1047,'Debit',13600.00,'2024-03-04 17:00:00'),
-- Account 1049 (Suresh Current)
(5080,1049,'Credit',340000.00,'2024-01-02 08:00:00'),
(5081,1049,'Debit',20000.00,'2024-01-17 15:30:00'),
-- Account 1051 (Anjali Savings)
(5082,1051,'Credit',21000.00,'2024-01-11 09:15:00'),
(5083,1051,'Debit',1700.00,'2024-01-27 12:45:00'),
(5084,1051,'Credit',6000.00,'2024-02-24 11:00:00'),
-- Account 1053 (Rajesh Savings)
(5085,1053,'Credit',87500.00,'2024-01-06 08:45:00'),
(5086,1053,'Debit',3800.50,'2024-01-22 14:15:00'),
(5087,1053,'Credit',11000.00,'2024-02-13 10:00:00'),
(5088,1053,'Debit',14800.00,'2024-03-10 16:30:00'),
-- Account 1055 (Swati Savings)
(5089,1055,'Credit',29000.00,'2024-01-15 09:00:00'),
(5090,1055,'Debit',1600.00,'2024-01-31 13:00:00'),
-- Account 1057 (Tarun Current)
(5091,1057,'Credit',225000.00,'2024-01-03 07:30:00'),
(5092,1057,'Debit',15000.00,'2024-01-19 16:00:00'),
(5093,1057,'Credit',18000.00,'2024-02-16 09:00:00'),
(5094,1057,'Debit',33000.00,'2024-03-02 12:00:00'),
-- Account 1059 (Pallavi Savings)
(5095,1059,'Credit',27000.00,'2024-01-13 09:30:00'),
(5096,1059,'Debit',1400.50,'2024-01-29 12:00:00'),
-- Account 1061 (Aditya Savings)
(5097,1061,'Credit',16000.00,'2024-01-17 08:00:00'),
(5098,1061,'Debit',1300.00,'2024-02-02 14:30:00'),
(5099,1061,'Credit',5000.00,'2024-02-25 11:15:00'),
(5100,1061,'Debit',5300.00,'2024-03-11 15:00:00'),
-- Account 1063 (Kirti Savings)
(5101,1063,'Credit',65000.00,'2024-01-07 09:00:00'),
(5102,1063,'Debit',2200.75,'2024-01-23 13:30:00'),
(5103,1063,'Credit',8000.00,'2024-02-18 10:45:00'),
-- Account 1065 (Vivek Current)
(5104,1065,'Credit',192000.00,'2024-01-02 08:00:00'),
(5105,1065,'Debit',8000.00,'2024-01-18 15:45:00'),
-- Account 1067 (Shweta Savings)
(5106,1067,'Credit',31000.00,'2024-01-10 09:15:00'),
(5107,1067,'Debit',1900.00,'2024-01-26 12:15:00'),
(5108,1067,'Credit',7000.00,'2024-02-22 11:30:00'),
(5109,1067,'Debit',9000.00,'2024-03-08 14:45:00'),
-- Account 1069 (Mohit Savings)
(5110,1069,'Credit',56000.00,'2024-01-04 08:30:00'),
(5111,1069,'Debit',2600.25,'2024-01-20 13:00:00'),
-- Account 1071 (Ishaan Savings)
(5112,1071,'Credit',13000.00,'2024-01-18 09:00:00'),
(5113,1071,'Debit',900.00,'2024-02-03 14:00:00'),
(5114,1071,'Credit',4000.00,'2024-02-26 11:00:00'),
-- Account 1073 (Komal Current)
(5115,1073,'Credit',280000.00,'2024-01-01 07:45:00'),
(5116,1073,'Debit',12000.00,'2024-01-21 16:30:00'),
(5117,1073,'Credit',20000.00,'2024-02-11 09:30:00'),
(5118,1073,'Debit',31600.00,'2024-03-03 12:30:00'),
-- Account 1075 (Neeraj Savings)
(5119,1075,'Credit',71000.00,'2024-01-08 09:30:00'),
(5120,1075,'Debit',2700.50,'2024-01-24 13:45:00'),
(5121,1075,'Credit',9000.00,'2024-02-19 10:00:00'),
-- Account 1077 (Rekha Savings)
(5122,1077,'Credit',33500.00,'2024-01-12 08:15:00'),
(5123,1077,'Debit',1700.00,'2024-01-28 12:30:00'),
-- Account 1079 (Saurabh Savings)
(5124,1079,'Credit',44500.00,'2024-01-11 09:45:00'),
(5125,1079,'Debit',1800.75,'2024-01-27 14:00:00'),
(5126,1079,'Credit',7000.00,'2024-02-23 11:30:00'),
(5127,1079,'Debit',7800.00,'2024-03-09 16:00:00'),
-- Account 1081 (Tanvi Current)
(5128,1081,'Credit',163000.00,'2024-01-03 08:00:00'),
(5129,1081,'Debit',7000.00,'2024-01-22 15:00:00'),
-- Account 1083 (Chirag Savings)
(5130,1083,'Credit',26000.00,'2024-01-14 09:00:00'),
(5131,1083,'Debit',1500.00,'2024-01-31 12:45:00'),
(5132,1083,'Credit',6000.00,'2024-02-27 11:00:00'),
(5133,1083,'Debit',6500.00,'2024-03-12 15:30:00'),
-- Account 1085 (Divyanka Savings)
(5134,1085,'Credit',19500.00,'2024-01-16 08:30:00'),
(5135,1085,'Debit',1600.50,'2024-02-01 13:15:00'),
-- Account 1087 (Harsh Savings)
(5136,1087,'Credit',79000.00,'2024-01-05 09:00:00'),
(5137,1087,'Debit',2400.00,'2024-01-21 14:30:00'),
(5138,1087,'Credit',11000.00,'2024-02-16 10:30:00'),
(5139,1087,'Debit',13400.00,'2024-03-05 17:00:00'),
-- Account 1089 (Lavanya Current)
(5140,1089,'Credit',310000.00,'2024-01-02 07:30:00'),
(5141,1089,'Debit',14000.00,'2024-01-19 16:15:00'),
-- Account 1091 (Mayank Savings)
(5142,1091,'Credit',22500.00,'2024-01-13 09:15:00'),
(5143,1091,'Debit',1800.00,'2024-01-29 12:00:00'),
(5144,1091,'Credit',5000.00,'2024-02-24 11:15:00'),
-- Account 1093 (Nandini Savings)
(5145,1093,'Credit',90000.00,'2024-01-06 08:45:00'),
(5146,1093,'Debit',3100.50,'2024-01-22 14:00:00'),
(5147,1093,'Credit',12000.00,'2024-02-13 10:15:00'),
(5148,1093,'Debit',15100.00,'2024-03-10 16:45:00'),
-- Account 1095 (Om Savings)
(5149,1095,'Credit',31500.00,'2024-01-15 09:00:00'),
(5150,1095,'Debit',1900.00,'2024-02-01 13:30:00'),
-- Account 1097 (Prerna Current)
(5151,1097,'Credit',200000.00,'2024-01-03 08:00:00'),
(5152,1097,'Debit',8000.00,'2024-01-20 16:00:00'),
(5153,1097,'Credit',15000.00,'2024-02-15 09:30:00'),
(5154,1097,'Debit',23000.00,'2024-03-01 12:15:00'),
-- Account 1099 (Qutub Savings)
(5155,1099,'Credit',29500.00,'2024-01-10 09:30:00'),
(5156,1099,'Debit',1700.50,'2024-01-26 12:45:00'),
-- Account 1101 (Rohini Savings)
(5157,1101,'Credit',17500.00,'2024-01-17 08:00:00'),
(5158,1101,'Debit',1200.00,'2024-02-03 14:15:00'),
(5159,1101,'Credit',5000.00,'2024-02-28 11:00:00'),
(5160,1101,'Debit',6200.00,'2024-03-13 15:15:00'),
-- Account 1103 (Sameer Savings)
(5161,1103,'Credit',68000.00,'2024-01-07 09:00:00'),
(5162,1103,'Debit',2600.75,'2024-01-23 13:00:00'),
(5163,1103,'Credit',9000.00,'2024-02-20 10:00:00'),
-- Account 1105 (Tara Current)
(5164,1105,'Credit',185000.00,'2024-01-02 08:00:00'),
(5165,1105,'Debit',9000.00,'2024-01-18 15:30:00'),
-- Account 1107 (Uday Savings)
(5166,1107,'Credit',32500.00,'2024-01-11 09:15:00'),
(5167,1107,'Debit',2000.00,'2024-01-27 12:15:00'),
(5168,1107,'Credit',7000.00,'2024-02-25 11:30:00'),
(5169,1107,'Debit',9000.00,'2024-03-11 15:45:00'),
-- Account 1109 (Vaishali Savings)
(5170,1109,'Credit',58500.00,'2024-01-04 08:45:00'),
(5171,1109,'Debit',2800.25,'2024-01-20 13:30:00'),
-- Account 1111 (Wasim Savings)
(5172,1111,'Credit',15000.00,'2024-01-19 09:00:00'),
(5173,1111,'Debit',1500.00,'2024-02-04 14:00:00'),
(5174,1111,'Credit',4000.00,'2024-02-29 11:00:00'),
-- Account 1113 (Xena Current)
(5175,1113,'Credit',257000.00,'2024-01-01 07:45:00'),
(5176,1113,'Debit',13000.00,'2024-01-22 16:00:00'),
(5177,1113,'Credit',21000.00,'2024-02-12 09:30:00'),
(5178,1113,'Debit',34000.00,'2024-03-04 12:45:00'),
-- Account 1115 (Yashpal Savings)
(5179,1115,'Credit',74500.00,'2024-01-09 09:30:00'),
(5180,1115,'Debit',2900.50,'2024-01-25 13:45:00'),
(5181,1115,'Credit',10000.00,'2024-02-21 10:00:00'),
-- Account 1117 (Zara Savings)
(5182,1117,'Credit',35000.00,'2024-01-13 08:15:00'),
(5183,1117,'Debit',1800.00,'2024-01-29 12:30:00'),
-- Account 1119 (Abhishek Savings)
(5184,1119,'Credit',47000.00,'2024-01-12 09:45:00'),
(5185,1119,'Debit',2200.75,'2024-01-28 14:00:00'),
(5186,1119,'Credit',8000.00,'2024-02-26 11:30:00'),
(5187,1119,'Debit',8200.00,'2024-03-12 16:15:00'),
-- Account 1121 (Bhavna Current)
(5188,1121,'Credit',171000.00,'2024-01-03 08:00:00'),
(5189,1121,'Debit',7000.00,'2024-01-23 15:15:00'),
-- Account 1123 (Chetan Savings)
(5190,1123,'Credit',27000.00,'2024-01-14 09:00:00'),
(5191,1123,'Debit',1100.00,'2024-01-31 12:45:00'),
(5192,1123,'Credit',5000.00,'2024-02-28 11:00:00'),
(5193,1123,'Debit',6100.00,'2024-03-13 15:30:00'),
-- Account 1125 (Deeksha Savings)
(5194,1125,'Credit',20500.00,'2024-01-16 08:30:00'),
(5195,1125,'Debit',1400.50,'2024-02-02 13:15:00'),
-- Account 1127 (Ekta Savings)
(5196,1127,'Credit',82000.00,'2024-01-05 09:00:00'),
(5197,1127,'Debit',2700.00,'2024-01-21 14:30:00'),
(5198,1127,'Credit',12000.00,'2024-02-17 10:30:00'),
(5199,1127,'Debit',11700.00,'2024-03-06 17:00:00'),
-- Account 1129 (Farhan Current)
(5200,1129,'Credit',325000.00,'2024-01-02 07:30:00'),
(5201,1129,'Debit',17000.00,'2024-01-20 16:15:00'),
-- Account 1131 (Geeta Savings)
(5202,1131,'Credit',23500.00,'2024-01-13 09:15:00'),
(5203,1131,'Debit',1600.00,'2024-01-30 12:00:00'),
(5204,1131,'Credit',5000.00,'2024-02-25 11:15:00'),
-- Account 1133 (Hemant Savings)
(5205,1133,'Credit',92000.00,'2024-01-06 08:45:00'),
(5206,1133,'Debit',2400.50,'2024-01-22 14:00:00'),
(5207,1133,'Credit',13000.00,'2024-02-14 10:15:00'),
(5208,1133,'Debit',13400.00,'2024-03-10 16:45:00'),
-- Account 1135 (Isha Savings)
(5209,1135,'Credit',34000.00,'2024-01-15 09:00:00'),
(5210,1135,'Debit',1900.00,'2024-02-02 13:30:00'),
-- Account 1137 (Jatin Current)
(5211,1137,'Credit',232000.00,'2024-01-03 08:00:00'),
(5212,1137,'Debit',12000.00,'2024-01-21 16:00:00'),
(5213,1137,'Credit',17000.00,'2024-02-16 09:30:00'),
(5214,1137,'Debit',29000.00,'2024-03-02 12:15:00'),
-- Account 1139 (Kamakshi Savings)
(5215,1139,'Credit',30500.00,'2024-01-10 09:30:00'),
(5216,1139,'Debit',1500.50,'2024-01-26 12:45:00'),
-- Account 1141 (Lokesh Savings)
(5217,1141,'Credit',19000.00,'2024-01-17 08:00:00'),
(5218,1141,'Debit',1200.00,'2024-02-04 14:15:00'),
(5219,1141,'Credit',5000.00,'2024-03-01 11:00:00'),
(5220,1141,'Debit',5200.00,'2024-03-14 15:15:00'),
-- Account 1143 (Madhuri Savings)
(5221,1143,'Credit',71000.00,'2024-01-07 09:00:00'),
(5222,1143,'Debit',2900.75,'2024-01-23 13:00:00'),
(5223,1143,'Credit',10000.00,'2024-02-21 10:00:00'),
-- Account 1145 (Navin Current)
(5224,1145,'Credit',196000.00,'2024-01-02 08:00:00'),
(5225,1145,'Debit',8000.00,'2024-01-19 15:30:00'),
-- Account 1147 (Ojasvi Savings)
(5226,1147,'Credit',34500.00,'2024-01-11 09:15:00'),
(5227,1147,'Debit',1600.00,'2024-01-28 12:15:00'),
(5228,1147,'Credit',7000.00,'2024-02-26 11:30:00'),
(5229,1147,'Debit',9500.00,'2024-03-12 15:45:00'),
-- Account 1149 (Prakash Savings)
(5230,1149,'Credit',60500.00,'2024-01-04 08:45:00'),
(5231,1149,'Debit',2100.25,'2024-01-20 13:30:00'),
-- Account 1151 (Qamar Savings)
(5232,1151,'Credit',16000.00,'2024-01-19 09:00:00'),
(5233,1151,'Debit',1200.00,'2024-02-05 14:00:00'),
(5234,1151,'Credit',4000.00,'2024-03-02 11:00:00'),
-- Account 1153 (Raveena Current)
(5235,1153,'Credit',289000.00,'2024-01-01 07:45:00'),
(5236,1153,'Debit',13000.00,'2024-01-23 16:00:00'),
(5237,1153,'Credit',22000.00,'2024-02-13 09:30:00'),
(5238,1153,'Debit',35000.00,'2024-03-05 12:45:00'),
-- Account 1155 (Sourav Savings)
(5239,1155,'Credit',76500.00,'2024-01-09 09:30:00'),
(5240,1155,'Debit',2600.50,'2024-01-25 13:45:00'),
(5241,1155,'Credit',11000.00,'2024-02-22 10:00:00'),
-- Account 1157 (Trisha Savings)
(5242,1157,'Credit',37500.00,'2024-01-13 08:15:00'),
(5243,1157,'Debit',2000.00,'2024-01-29 12:30:00'),
-- Account 1159 (Ujjwal Savings)
(5244,1159,'Credit',49000.00,'2024-01-12 09:45:00'),
(5245,1159,'Debit',2900.75,'2024-01-28 14:00:00'),
(5246,1159,'Credit',9000.00,'2024-02-27 11:30:00'),
(5247,1159,'Debit',9900.00,'2024-03-13 16:15:00'),
-- Account 1161 (Vrinda Current)
(5248,1161,'Credit',179000.00,'2024-01-03 08:00:00'),
(5249,1161,'Debit',7000.00,'2024-01-24 15:15:00'),
-- Account 1163 (Waqar Savings)
(5250,1163,'Credit',29000.00,'2024-01-14 09:00:00'),
(5251,1163,'Debit',1800.00,'2024-02-01 12:45:00'),
(5252,1163,'Credit',6000.00,'2024-03-01 11:00:00'),
(5253,1163,'Debit',7800.00,'2024-03-14 15:30:00'),
-- Account 1165 (Xenia Savings)
(5254,1165,'Credit',21500.00,'2024-01-16 08:30:00'),
(5255,1165,'Debit',1100.50,'2024-02-03 13:15:00'),
-- Account 1167 (Yogesh Savings)
(5256,1167,'Credit',85000.00,'2024-01-05 09:00:00'),
(5257,1167,'Debit',3000.00,'2024-01-21 14:30:00'),
(5258,1167,'Credit',13000.00,'2024-02-18 10:30:00'),
(5259,1167,'Debit',13000.00,'2024-03-07 17:00:00'),
-- Account 1169 (Zeena Current)
(5260,1169,'Credit',330000.00,'2024-01-02 07:30:00'),
(5261,1169,'Debit',14000.00,'2024-01-21 16:15:00'),
-- Account 1171 (Anand Savings)
(5262,1171,'Credit',25000.00,'2024-01-13 09:15:00'),
(5263,1171,'Debit',1800.00,'2024-01-30 12:00:00'),
(5264,1171,'Credit',5000.00,'2024-02-26 11:15:00'),
-- Account 1173 (Bhumi Savings)
(5265,1173,'Credit',95500.00,'2024-01-06 08:45:00'),
(5266,1173,'Debit',3200.50,'2024-01-22 14:00:00'),
(5267,1173,'Credit',14000.00,'2024-02-15 10:15:00'),
(5268,1173,'Debit',17200.00,'2024-03-11 16:45:00'),
-- Account 1175 (Chandrashekhar Savings)
(5269,1175,'Credit',37000.00,'2024-01-15 09:00:00'),
(5270,1175,'Debit',2300.00,'2024-02-02 13:30:00'),
-- Account 1177 (Daksha Current)
(5271,1177,'Credit',238000.00,'2024-01-03 08:00:00'),
(5272,1177,'Debit',10000.00,'2024-01-22 16:00:00'),
(5273,1177,'Credit',18000.00,'2024-02-17 09:30:00'),
(5274,1177,'Debit',28000.00,'2024-03-03 12:15:00'),
-- Account 1179 (Eshan Savings)
(5275,1179,'Credit',32000.00,'2024-01-10 09:30:00'),
(5276,1179,'Debit',1700.50,'2024-01-27 12:45:00'),
(5277,1179,'Credit',7000.00,'2024-02-28 11:00:00'),
(5278,1179,'Debit',8700.00,'2024-03-14 15:45:00');

-- ---------------------------------------------------------------
-- 4. BENEFICIARIES  (120 rows)
-- ---------------------------------------------------------------
INSERT INTO beneficiary (beneficiary_id, customer_id, name, accountNumber, bankDetails) VALUES
(9001,1,'Rohan Mehta','100500001234','HDFC Bank, Mumbai'),
(9002,1,'Amit Verma','200600002345','SBI, Lucknow'),
(9003,2,'Vikram Singh','300700003456','ICICI Bank, Delhi'),
(9004,2,'Kavya Krishnan','400800004567','Axis Bank, Bengaluru'),
(9005,3,'Priya Patel','500900005678','Kotak Bank, Mumbai'),
(9006,3,'Sneha Reddy','601000006789','Yes Bank, Hyderabad'),
(9007,4,'Aarav Sharma','702000007890','HDFC Bank, Mumbai'),
(9008,4,'Karan Malhotra','803000008901','Punjab National Bank, Chandigarh'),
(9009,5,'Meera Joshi','904000009012','Union Bank, Pune'),
(9010,5,'Rahul Gupta','005000000123','SBI, Delhi'),
(9011,6,'Divya Nair','106000001234','Federal Bank, Kochi'),
(9012,6,'Arjun Kapoor','207000002345','HDFC Bank, Mumbai'),
(9013,7,'Neha Bansal','308000003456','ICICI Bank, Delhi'),
(9014,7,'Sunita Pillai','409000004567','Canara Bank, Mumbai'),
(9015,8,'Gaurav Mishra','510000005678','SBI, Lucknow'),
(9016,8,'Nikhil Choudhary','611000006789','Axis Bank, Kolkata'),
(9017,9,'Ritu Aggarwal','712000007890','Kotak Bank, Delhi'),
(9018,9,'Manish Kumar','813000008901','SBI, Bhopal'),
(9019,10,'Shruti Desai','914000009012','HDFC Bank, Ahmedabad'),
(9020,10,'Deepak Pandey','015000000123','Bank of Baroda, Lucknow'),
(9021,11,'Priyanka Saxena','116000001234','ICICI Bank, Jaipur'),
(9022,11,'Suresh Naik','217000002345','Canara Bank, Goa'),
(9023,12,'Anjali Bose','318000003456','SBI, Kolkata'),
(9024,12,'Rajesh Patil','419000004567','Bank of Maharashtra, Pune'),
(9025,13,'Swati Ghosh','520000005678','SBI, Kolkata'),
(9026,13,'Tarun Jain','621000006789','Axis Bank, Delhi'),
(9027,14,'Pallavi Deshpande','722000007890','HDFC Bank, Pune'),
(9028,14,'Aditya Srivastava','823000008901','SBI, Lucknow'),
(9029,15,'Kirti Menon','924000009012','Federal Bank, Chennai'),
(9030,15,'Vivek Chauhan','025000000123','SBI, Dehradun'),
(9031,16,'Shweta Kulkarni','126000001234','HDFC Bank, Pune'),
(9032,16,'Mohit Arora','227000002345','ICICI Bank, Delhi'),
(9033,17,'Ishaan Bhat','328000003456','Axis Bank, Bengaluru'),
(9034,17,'Komal Shah','429000004567','SBI, Ahmedabad'),
(9035,18,'Neeraj Tomar','530000005678','ICICI Bank, Noida'),
(9036,18,'Rekha Nambiar','631000006789','Federal Bank, Kochi'),
(9037,19,'Saurabh Dubey','732000007890','SBI, Delhi'),
(9038,19,'Tanvi Hegde','833000008901','HDFC Bank, Bengaluru'),
(9039,20,'Chirag Patel','934000009012','Axis Bank, Ahmedabad'),
(9040,20,'Divyanka Tripathi','035000000123','SBI, Varanasi'),
(9041,21,'Harsh Vardhan','136000001234','ICICI Bank, Delhi'),
(9042,21,'Lavanya Suresh','237000002345','Canara Bank, Chennai'),
(9043,22,'Mayank Joshi','338000003456','SBI, Bhopal'),
(9044,22,'Nandini Kaur','439000004567','Punjab National Bank, Chandigarh'),
(9045,23,'Om Prakash Yadav','540000005678','SBI, Gorakhpur'),
(9046,23,'Prerna Sinha','641000006789','Bank of Baroda, Kanpur'),
(9047,24,'Qutub Ansari','742000007890','SBI, Patna'),
(9048,24,'Rohini Devi','843000008901','HDFC Bank, Hyderabad'),
(9049,25,'Sameer Khan','944000009012','ICICI Bank, Mumbai'),
(9050,25,'Tara Pillai','045000000123','Federal Bank, Thiruvananthapuram'),
(9051,26,'Uday Shankar','146000001234','SBI, Bhubaneswar'),
(9052,26,'Vaishali Mane','247000002345','Bank of Maharashtra, Pune'),
(9053,27,'Wasim Sheikh','348000003456','ICICI Bank, Delhi'),
(9054,27,'Xena Thomas','449000004567','Federal Bank, Kochi'),
(9055,28,'Yashpal Rathore','550000005678','Axis Bank, Jaipur'),
(9056,28,'Zara Hussain','651000006789','HDFC Bank, Pune'),
(9057,29,'Abhishek Tiwari','752000007890','SBI, Lucknow'),
(9058,29,'Bhavna Mittal','853000008901','ICICI Bank, Delhi'),
(9059,30,'Chetan Khatri','954000009012','Axis Bank, Ahmedabad'),
(9060,30,'Deeksha Bajaj','055000000123','SBI, Delhi'),
(9061,31,'Ekta Soni','156000001234','SBI, Nagpur'),
(9062,31,'Farhan Qureshi','257000002345','HDFC Bank, Hyderabad'),
(9063,32,'Geeta Nair','358000003456','Federal Bank, Kochi'),
(9064,32,'Hemant Dixit','459000004567','ICICI Bank, Delhi'),
(9065,33,'Isha Chadha','560000005678','Axis Bank, Gurugram'),
(9066,33,'Jatin Sethi','661000006789','Punjab National Bank, Ludhiana'),
(9067,34,'Kamakshi Venkatesan','762000007890','Canara Bank, Chennai'),
(9068,34,'Lokesh Pandey','863000008901','SBI, Patna'),
(9069,35,'Madhuri Shetty','964000009012','Canara Bank, Mangalore'),
(9070,35,'Navin Trivedi','065000000123','Axis Bank, Ahmedabad'),
(9071,36,'Ojasvi Rawat','166000001234','SBI, Dehradun'),
(9072,36,'Prakash Rao','267000002345','HDFC Bank, Hyderabad'),
(9073,37,'Qamar Fatima','368000003456','SBI, Hyderabad'),
(9074,37,'Raveena Tandon','469000004567','ICICI Bank, Mumbai'),
(9075,38,'Sourav Mondal','570000005678','SBI, Kolkata'),
(9076,38,'Trisha Mukherjee','671000006789','Axis Bank, Kolkata'),
(9077,39,'Ujjwal Sood','772000007890','Punjab National Bank, Amritsar'),
(9078,39,'Vrinda Rastogi','873000008901','ICICI Bank, Delhi'),
(9079,40,'Waqar Ahmed','974000009012','HDFC Bank, Hyderabad'),
(9080,40,'Xenia D''Souza','075000000123','Goa State Co-op Bank, Goa'),
(9081,41,'Yogesh Garg','176000001234','SBI, Delhi'),
(9082,41,'Zeena Krishnaswamy','277000002345','Canara Bank, Coimbatore'),
(9083,42,'Anand Venkataraman','378000003456','HDFC Bank, Chennai'),
(9084,42,'Bhumi Pednekar','479000004567','ICICI Bank, Mumbai'),
(9085,43,'Chandrashekhar Azad','580000005678','SBI, Indore'),
(9086,43,'Daksha Parmar','681000006789','Axis Bank, Ahmedabad'),
(9087,44,'Eshan Malviya','782000007890','SBI, Indore'),
(9088,44,'Falguni Pathak','883000008901','Axis Bank, Ahmedabad'),
(9089,45,'Girish Karnad','984000009012','Canara Bank, Bengaluru'),
(9090,45,'Hemlata Pant','085000000123','SBI, Rudrapur'),
(9091,46,'Ishan Khatter','186000001234','HDFC Bank, Mumbai'),
(9092,46,'Jasmin Bhasin','287000002345','Punjab National Bank, Chandigarh'),
(9093,47,'Kuldeep Yadav','388000003456','ICICI Bank, Delhi'),
(9094,47,'Lata Mangeshkar','489000004567','HDFC Bank, Mumbai'),
(9095,48,'Mihir Desai','590000005678','Axis Bank, Ahmedabad'),
(9096,48,'Nita Ambani','691000006789','HDFC Bank, Mumbai'),
(9097,49,'Om Shanti Das','792000007890','SBI, Kolkata'),
(9098,49,'Padmavathi Rajan','893000008901','Canara Bank, Tirunelveli'),
(9099,50,'Quresh Momin','994000009012','ICICI Bank, Mumbai'),
(9100,50,'Ramdas Athavale','095000000123','SBI, Mumbai'),
(9101,51,'Sarla Bhosle','196000001234','Bank of Maharashtra, Pune'),
(9102,51,'Tejas Menon','297000002345','Federal Bank, Kerala'),
(9103,52,'Uma Shankar Gupta','398000003456','SBI, Allahabad'),
(9104,52,'Veer Pahariya','499000004567','ICICI Bank, Delhi'),
(9105,53,'Wriddhiman Saha','500000005678','SBI, Kolkata'),
(9106,53,'Xander Fernandes','601000006789','Goa State Co-op Bank, Goa'),
(9107,54,'Yamini Krishnan','702000007890','Canara Bank, Chennai'),
(9108,54,'Zubair Siddiqui','803000008901','SBI, Delhi'),
(9109,55,'Aruna Iyer','904000009012','Canara Bank, Chennai'),
(9110,55,'Brijesh Sinha','005000000123','SBI, Patna'),
(9111,56,'Charu Sharma','106000001234','HDFC Bank, Delhi'),
(9112,56,'Devraj Nair','207000002345','Federal Bank, Thrissur'),
(9113,57,'Eshaan Qazi','308000003456','J&K Bank, Srinagar'),
(9114,57,'Fiona D''Costa','409000004567','Goa State Co-op Bank, Goa'),
(9115,58,'Govind Swami','510000005678','SBI, Ajmer'),
(9116,58,'Harshita Agarwal','611000006789','ICICI Bank, Ghaziabad'),
(9117,59,'Indrani Mukherjee','712000007890','SBI, Kolkata'),
(9118,59,'Aarav Sharma','100500001234','HDFC Bank, Mumbai'),
(9119,60,'Priya Patel','100300003456','Kotak Bank, Bengaluru'),
(9120,60,'Rohan Mehta','100500005678','SBI, Kolkata');

-- ============================================================
--  SUMMARY
--  customer    : 120 rows
--  account     : 180 rows
--  transaction : 278 rows  (≥500 total rows across all tables)
--  beneficiary : 120 rows
--  GRAND TOTAL : 698 rows
-- ============================================================