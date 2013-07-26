# Enable FKs:
# 
# $DB_FKS
# 
ALTER TABLE form_field ADD CONSTRAINT FK_form_id FOREIGN KEY FK_form_field_1 (form_id)
    REFERENCES form (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
, ROW_FORMAT = DYNAMIC;

ALTER TABLE form_response ADD CONSTRAINT FK_incident FOREIGN KEY FK_form_response_2 (incident_id)
    REFERENCES incident (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
, ROW_FORMAT = DYNAMIC;

ALTER TABLE form_response ADD CONSTRAINT FK_form_field FOREIGN KEY FK_form_response_1 (form_field_id)
    REFERENCES form_field (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
, ROW_FORMAT = DYNAMIC;

ALTER TABLE form_field_option ADD CONSTRAINT FK_form_field_option_1 FOREIGN KEY FK_form_field_option_1 (form_field_id)
    REFERENCES form_field (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
, ROW_FORMAT = DYNAMIC;

