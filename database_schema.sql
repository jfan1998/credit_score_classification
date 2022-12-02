CREATE TABLE customers (
	customer_id 				int,
	name 						varchar(100) NOT NULL,
	age							int NOT NULL,
	SSN 						varchar(30) NOT NULL UNIQUE,
	occupation 					varchar(100) NOT NULL,
	annual_income 				numeric(10,2) NOT NULL,
	PRIMARY KEY (customer_id)
);

CREATE TABLE customer_month (
	id 							int,
	customer_id 				int NOT NULL,
	month 						int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE loans (
	loan_id 					int,
	type_of_loan				varchar(60) NOT NULL,
	PRIMARY KEY (loan_id)
);

CREATE TABLE customer_payment_behavior (
	behavior_id					int,
	payment_behavior			varchar(100) NOT NULL,
	PRIMARY KEY (behavior_id)
);

CREATE TABLE customer_monthly_balance (
	id							int,
	monthly_balance				numeric(10,2) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id) REFERENCES customer_month (id)
);

CREATE TABLE customer_delay(
	id 							int,
	delay_from_due_date 		int NOT NULL,
	num_of_delayed_payment 		int NOT NULL,
	payment_of_min_amount 		varchar NOT NULL,
	PRIMARY KEY (id),
	CHECK (payment_of_min_amount IN ('YES', 'NO')),
	FOREIGN KEY (id) REFERENCES customer_month (id)
);


CREATE TABLE customer_loan_amount (
	id 							int,
	outstanding_debt 			numeric(10,2) NOT NULL,
	total_emi_per_month 		numeric(10,2) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id) REFERENCES customer_month (id)
);

CREATE TABLE  credit_score (
	credit_score_id 			int,
	credit_score 				varchar(10) NOT NULL,
PRIMARY KEY (credit_score_id)
);

CREATE TABLE credit_mix (
	credit_mix_id 				int,
	credit_mix    				varchar(10) NOT NULL,
	PRIMARY KEY (credit_mix_id)
);

CREATE TABLE customer_monthly_income (
	id                    		int,
	monthly_inhand_salary 		numeric(10,2) NOT NULL,
	PRIMARY KEY (id),
 	FOREIGN KEY (id) REFERENCES customer_month (id)
);

CREATE TABLE customer_monthly_spent (
	id   						int,
	total_emi_per_month   		numeric(10,2) NOT NULL,
	amount_invested_monthly 	numeric(10,2) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (id) REFERENCES customer_month (id)
);

CREATE TABLE customer_credit (
	id   						int,
	credit_score_id   			int NOT NULL,
	num_credit_inquiries   		int NOT NULL,
	credit_history_age   		int NOT NULL,
	credit_utilization_ratio   	numeric(5,2) NOT NULL,
	changed_credit_limit   		numeric(5,2) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (credit_score_id) REFERENCES credit_score (credit_score_id),
	FOREIGN KEY (id) REFERENCES customer_month (id)
);

CREATE TABLE customer_loan (
	customer_id					int,
	loan_id						int,
	num_of_loan					int NOT NULL,
	PRIMARY KEY (customer_id, loan_id),
	FOREIGN KEY (loan_id) REFERENCES loans (loan_id),
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE customer_annual_credit (
	customer_id					int,
	credit_mix_id				int NOT NULL,
	PRIMARY KEY (customer_id),
	FOREIGN KEY (credit_mix_id) REFERENCES credit_mix (credit_mix_id),
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE customer_bank_information (
	id							int,
	num_bank_accounts			int NOT NULL,
	num_credit_card				int NOT NULL,
	interest_rate				int NOT NULL,
	num_of_loan					int NOT NULL,
	behavior_id					int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (behavior_id) REFERENCES customer_payment_behavior (behavior_id),
	FOREIGN KEY (id) REFERENCES customer_month (id)
);

