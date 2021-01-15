CREATE TABLE pins (
	id bigserial PRIMARY KEY,
	pin varchar(20) NOT NULL,
	pin_list_id int NOT NULL,
	redeemed_at timestamp,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP
);	

CREATE INDEX idx_pinlist_pin ON pins (pin_list_id, pin);