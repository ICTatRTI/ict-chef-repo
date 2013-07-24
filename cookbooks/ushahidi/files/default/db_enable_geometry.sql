
# Add a GEOMETRY column to location table:

ALTER TABLE location ADD COLUMN location_point GEOMETRY;

# Convert existing records:

UPDATE location SET location_point = POINT(longitude, latitude);

# Triggers to fill the GEOMETRY value when a record is inserted/updated:
 
CREATE TRIGGER InsertLocationGeometry BEFORE INSERT ON location FOR EACH ROW SET NEW.location_point = POINT(NEW.longitude, NEW.latitude);
CREATE TRIGGER UpdateLocationGeometry BEFORE UPDATE ON location FOR EACH ROW SET NEW.location_point = POINT(NEW.longitude, NEW.latitude);

