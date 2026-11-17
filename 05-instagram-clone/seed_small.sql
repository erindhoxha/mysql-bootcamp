-- Small hand-written seed for testing the schema.
-- Run after schema.sql. For the full dataset use data/ig_clone_data.sql instead.
USE ig_clone;

INSERT INTO users (username) VALUES ('alice'), ('bob'), ('carol');

INSERT INTO photos (image_url, user_id) VALUES
('https://images.pexels.com/photos/36022259/pexels-photo-36022259.jpeg', 1),
('https://images.pexels.com/photos/36022259/pexels-photo-36022259.jpeg', 1),
('https://images.pexels.com/photos/36022259/pexels-photo-36022259.jpeg', 2);

INSERT INTO comments (comment_text, user_id, photo_id) VALUES
('Nice shot!', 2, 1),
('Love this', 3, 1),
('Cool', 1, 3);

INSERT INTO likes (user_id, photo_id) VALUES (1, 1), (1, 2), (2, 1);

INSERT INTO follows (follower_id, followee_id) VALUES (1, 2), (2, 1), (3, 1);

INSERT INTO tags (tag_name) VALUES ('sunset'), ('happy');

INSERT INTO photo_tags (photo_id, tag_id) VALUES (1, 1), (1, 2), (2, 1);
