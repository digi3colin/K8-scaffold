
CREATE TABLE persons(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
first_name TEXT NOT NULL ,
last_name TEXT NOT NULL ,
phone TEXT ,
email TEXT
);

CREATE TRIGGER persons_updated_at AFTER UPDATE ON persons WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE persons SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE addresses(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
address1 TEXT NOT NULL ,
address2 TEXT NOT NULL ,
city TEXT ,
company TEXT ,
country TEXT ,
country_code TEXT ,
province TEXT ,
province_code TEXT ,
street TEXT ,
zip TEXT
);

CREATE TRIGGER addresses_updated_at AFTER UPDATE ON addresses WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE addresses SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE roles(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL
);

CREATE TRIGGER roles_updated_at AFTER UPDATE ON roles WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE roles SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE blogs(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
content TEXT ,
handle TEXT ,
title TEXT ,
description TEXT ,
comments_enabled BOOLEAN NOT NULL DEFAULT TRUE ,
moderated BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TRIGGER blogs_updated_at AFTER UPDATE ON blogs WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE blogs SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE images(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
alt TEXT ,
attached_to_variant BOOLEAN NOT NULL DEFAULT FALSE ,
src TEXT NOT NULL ,
height INTEGER ,
width INTEGER
);

CREATE TRIGGER images_updated_at AFTER UPDATE ON images WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE images SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE currencies(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
code TEXT NOT NULL
);

CREATE TRIGGER currencies_updated_at AFTER UPDATE ON currencies WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE currencies SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE payment_types(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
type TEXT
);

CREATE TRIGGER payment_types_updated_at AFTER UPDATE ON payment_types WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE payment_types SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE metafields(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL
);

CREATE TRIGGER metafields_updated_at AFTER UPDATE ON metafields WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE metafields SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE conditions(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
rule TEXT NOT NULL ,
condition TEXT NOT NULL ,
value TEXT NOT NULL
);

CREATE TRIGGER conditions_updated_at AFTER UPDATE ON conditions WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE conditions SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE sorts(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL
);

CREATE TRIGGER sorts_updated_at AFTER UPDATE ON sorts WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE sorts SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE options(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL ,
weight INTEGER NOT NULL
);

CREATE TRIGGER options_updated_at AFTER UPDATE ON options WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE options SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE tags(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL
);

CREATE TRIGGER tags_updated_at AFTER UPDATE ON tags WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE tags SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE types(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL
);

CREATE TRIGGER types_updated_at AFTER UPDATE ON types WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE types SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE vendors(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL
);

CREATE TRIGGER vendors_updated_at AFTER UPDATE ON vendors WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE vendors SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE cart_attributes(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL ,
cart_id INTEGER NOT NULL ,
FOREIGN KEY (cart_id) REFERENCES carts (id) ON DELETE CASCADE
);

CREATE TRIGGER cart_attributes_updated_at AFTER UPDATE ON cart_attributes WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE cart_attributes SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE fulfilments(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
tracking_company TEXT NOT NULL ,
tracking_number TEXT NOT NULL ,
tracking_url TEXT
);

CREATE TRIGGER fulfilments_updated_at AFTER UPDATE ON fulfilments WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE fulfilments SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE discount_applications(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
target_selection TEXT NOT NULL ,
target_type TEXT NOT NULL ,
title TEXT NOT NULL ,
type TEXT NOT NULL ,
value INTEGER NOT NULL ,
value_type TEXT NOT NULL
);

CREATE TRIGGER discount_applications_updated_at AFTER UPDATE ON discount_applications WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE discount_applications SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE discounts(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
amount INTEGER NOT NULL ,
savings INTEGER ,
code TEXT ,
type TEXT NOT NULL
);

CREATE TRIGGER discounts_updated_at AFTER UPDATE ON discounts WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE discounts SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE line_item_properties(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL ,
line_item_id INTEGER NOT NULL ,
FOREIGN KEY (line_item_id) REFERENCES line_items (id) ON DELETE CASCADE
);

CREATE TRIGGER line_item_properties_updated_at AFTER UPDATE ON line_item_properties WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE line_item_properties SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE shipping_methods(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
handle TEXT NOT NULL ,
original_price INTEGER ,
price INTEGER
);

CREATE TRIGGER shipping_methods_updated_at AFTER UPDATE ON shipping_methods WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE shipping_methods SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE tax_lines(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
price INTEGER ,
rate_percentage INTEGER NOT NULL
);

CREATE TRIGGER tax_lines_updated_at AFTER UPDATE ON tax_lines WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE tax_lines SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE transactions(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
amount INTEGER NOT NULL ,
gateway TEXT NOT NULL ,
kind TEXT ,
receipt TEXT ,
status TEXT
);

CREATE TRIGGER transactions_updated_at AFTER UPDATE ON transactions WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE transactions SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE paymentDetails(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL ,
transaction_id INTEGER NOT NULL ,
FOREIGN KEY (transaction_id) REFERENCES transactions (id) ON DELETE CASCADE
);

CREATE TRIGGER paymentDetails_updated_at AFTER UPDATE ON paymentDetails WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE paymentDetails SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE users(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
username TEXT NOT NULL ,
password TEXT NOT NULL ,
person_id INTEGER NOT NULL ,
role_id INTEGER ,
FOREIGN KEY (person_id) REFERENCES persons (id) ON DELETE CASCADE ,
FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE SET NULL
);

CREATE TRIGGER users_updated_at AFTER UPDATE ON users WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE orders(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
cancelled BOOLEAN NOT NULL DEFAULT FALSE ,
cancelled_at DATETIME ,
cancel_reason TEXT ,
customer_url TEXT ,
financial_status TEXT ,
fulfillment_status TEXT ,
location TEXT ,
note TEXT ,
order_number TEXT ,
order_status_url TEXT ,
phone TEXT ,
shipping_price INTEGER NOT NULL ,
subtotal_price INTEGER NOT NULL ,
tax_price INTEGER NOT NULL ,
total_discounts INTEGER NOT NULL ,
total_net_amount INTEGER NOT NULL ,
total_price INTEGER NOT NULL ,
total_refunded_amount INTEGER ,
customer_id INTEGER NOT NULL ,
billing_address_id INTEGER ,
shipping_address_id INTEGER ,
FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE ,
FOREIGN KEY (billing_address_id) REFERENCES addresses (id) ON DELETE SET NULL ,
FOREIGN KEY (shipping_address_id) REFERENCES addresses (id) ON DELETE SET NULL
);

CREATE TRIGGER orders_updated_at AFTER UPDATE ON orders WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE orders SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE order_tags(
order_id INTEGER NOT NULL,
tag_id INTEGER NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE ,
FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE
);



CREATE TABLE articles(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
content TEXT ,
handle TEXT ,
title TEXT ,
description TEXT ,
excerpt TEXT ,
author TEXT NOT NULL ,
moderated BOOLEAN ,
published_at DATETIME ,
user_id INTEGER NOT NULL ,
blog_id INTEGER ,
FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ,
FOREIGN KEY (blog_id) REFERENCES blogs (id) ON DELETE SET NULL
);

CREATE TRIGGER articles_updated_at AFTER UPDATE ON articles WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE articles SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE article_images(
article_id INTEGER NOT NULL,
image_id INTEGER NOT NULL,
FOREIGN KEY (article_id) REFERENCES articles (id) ON DELETE CASCADE ,
FOREIGN KEY (image_id) REFERENCES images (id) ON DELETE CASCADE
);


CREATE TABLE article_tags(
article_id INTEGER NOT NULL,
tag_id INTEGER NOT NULL,
FOREIGN KEY (article_id) REFERENCES articles (id) ON DELETE CASCADE ,
FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE
);



CREATE TABLE comments(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
author TEXT NOT NULL ,
content TEXT NOT NULL ,
email TEXT NOT NULL ,
status TEXT NOT NULL ,
url TEXT ,
article_id INTEGER NOT NULL ,
FOREIGN KEY (article_id) REFERENCES articles (id) ON DELETE CASCADE
);

CREATE TRIGGER comments_updated_at AFTER UPDATE ON comments WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE comments SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE customers(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
accepts_marketing BOOLEAN NOT NULL DEFAULT FALSE ,
has_account BOOLEAN ,
last_order DATETIME ,
tax_exempt BOOLEAN ,
total_spent INTEGER ,
person_id INTEGER NOT NULL ,
address_id INTEGER ,
FOREIGN KEY (person_id) REFERENCES persons (id) ON DELETE CASCADE ,
FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE SET NULL
);

CREATE TRIGGER customers_updated_at AFTER UPDATE ON customers WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE customers SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE customer_tags(
customer_id INTEGER NOT NULL,
tag_id INTEGER NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE ,
FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE
);



CREATE TABLE pages(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
content TEXT ,
handle TEXT ,
title TEXT ,
description TEXT ,
template_suffix TEXT ,
author TEXT ,
published_at DATETIME ,
user_id INTEGER NOT NULL ,
FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TRIGGER pages_updated_at AFTER UPDATE ON pages WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE pages SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE shops(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
content TEXT ,
handle TEXT ,
title TEXT ,
description TEXT ,
domain TEXT ,
email TEXT ,
locale TEXT ,
money_format TEXT ,
money_with_currency_format TEXT ,
password_message TEXT ,
permanent_domain TEXT ,
phone TEXT ,
taxes_included BOOLEAN NOT NULL DEFAULT FALSE ,
address_id INTEGER ,
default_currency_id INTEGER ,
payment_type_id INTEGER ,
FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE SET NULL ,
FOREIGN KEY (default_currency_id) REFERENCES currencies (id) ON DELETE SET NULL ,
FOREIGN KEY (payment_type_id) REFERENCES payment_types (id) ON DELETE SET NULL
);

CREATE TRIGGER shops_updated_at AFTER UPDATE ON shops WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE shops SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE shop_currencies(
shop_id INTEGER NOT NULL,
currency_id INTEGER NOT NULL,
FOREIGN KEY (shop_id) REFERENCES shops (id) ON DELETE CASCADE ,
FOREIGN KEY (currency_id) REFERENCES currencies (id) ON DELETE CASCADE
);


CREATE TABLE shop_metafields(
shop_id INTEGER NOT NULL,
metafield_id INTEGER NOT NULL,
FOREIGN KEY (shop_id) REFERENCES shops (id) ON DELETE CASCADE ,
FOREIGN KEY (metafield_id) REFERENCES metafields (id) ON DELETE CASCADE
);



CREATE TABLE policies(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
content TEXT ,
handle TEXT ,
title TEXT ,
description TEXT ,
shop_id INTEGER NOT NULL ,
FOREIGN KEY (shop_id) REFERENCES shops (id) ON DELETE CASCADE
);

CREATE TRIGGER policies_updated_at AFTER UPDATE ON policies WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE policies SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE products(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
content TEXT ,
handle TEXT ,
title TEXT ,
description TEXT ,
template_suffix TEXT ,
available BOOLEAN ,
default_image_id INTEGER ,
type_id INTEGER ,
vendor_id INTEGER ,
FOREIGN KEY (default_image_id) REFERENCES images (id) ON DELETE SET NULL ,
FOREIGN KEY (type_id) REFERENCES types (id) ON DELETE SET NULL ,
FOREIGN KEY (vendor_id) REFERENCES vendors (id) ON DELETE SET NULL
);

CREATE TRIGGER products_updated_at AFTER UPDATE ON products WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE products SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE product_images(
product_id INTEGER NOT NULL,
image_id INTEGER NOT NULL,
FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE ,
FOREIGN KEY (image_id) REFERENCES images (id) ON DELETE CASCADE
);


CREATE TABLE product_tags(
product_id INTEGER NOT NULL,
tag_id INTEGER NOT NULL,
FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE ,
FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE
);


CREATE TABLE product_options(
product_id INTEGER NOT NULL,
option_id INTEGER NOT NULL,
FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE ,
FOREIGN KEY (option_id) REFERENCES options (id) ON DELETE CASCADE
);



CREATE TABLE collections(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
content TEXT ,
handle TEXT ,
title TEXT ,
description TEXT ,
template_suffix TEXT ,
match_all_condition BOOLEAN NOT NULL DEFAULT TRUE ,
published_at DATETIME ,
image_id INTEGER ,
sort_id INTEGER ,
FOREIGN KEY (image_id) REFERENCES images (id) ON DELETE SET NULL ,
FOREIGN KEY (sort_id) REFERENCES sorts (id) ON DELETE SET NULL
);

CREATE TRIGGER collections_updated_at AFTER UPDATE ON collections WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE collections SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE collection_conditions(
collection_id INTEGER NOT NULL,
condition_id INTEGER NOT NULL,
FOREIGN KEY (collection_id) REFERENCES collections (id) ON DELETE CASCADE ,
FOREIGN KEY (condition_id) REFERENCES conditions (id) ON DELETE CASCADE
);


CREATE TABLE collection_products(
collection_id INTEGER NOT NULL,
product_id INTEGER NOT NULL,
FOREIGN KEY (collection_id) REFERENCES collections (id) ON DELETE CASCADE ,
FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);



CREATE TABLE variants(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
available BOOLEAN NOT NULL ,
barcode TEXT ,
compare_at_price INTEGER ,
incoming BOOLEAN ,
inventory_management TEXT ,
inventory_policy TEXT ,
inventory_quantity INTEGER NOT NULL ,
next_incoming_date DATETIME ,
option1 TEXT ,
option2 TEXT ,
option3 TEXT ,
price INTEGER NOT NULL ,
requires_shipping BOOLEAN NOT NULL DEFAULT TRUE ,
selected BOOLEAN ,
sku TEXT ,
taxable BOOLEAN NOT NULL ,
title TEXT ,
url TEXT ,
weight INTEGER ,
weight_unit TEXT ,
weight_in_unit REAL ,
product_id INTEGER NOT NULL ,
FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TRIGGER variants_updated_at AFTER UPDATE ON variants WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE variants SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE variant_images(
variant_id INTEGER NOT NULL,
image_id INTEGER NOT NULL,
FOREIGN KEY (variant_id) REFERENCES variants (id) ON DELETE CASCADE ,
FOREIGN KEY (image_id) REFERENCES images (id) ON DELETE CASCADE
);



CREATE TABLE carts(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
note TEXT ,
original_total_price INTEGER NOT NULL ,
total_discount INTEGER ,
total_price INTEGER NOT NULL ,
total_weight INTEGER ,
currency_id INTEGER ,
FOREIGN KEY (currency_id) REFERENCES currencies (id) ON DELETE SET NULL
);

CREATE TRIGGER carts_updated_at AFTER UPDATE ON carts WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE carts SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE line_items(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
final_price INTEGER ,
fulfillment_service TEXT ,
gift_card BOOLEAN ,
grams INTEGER ,
key TEXT ,
message TEXT ,
original_price INTEGER ,
price INTEGER ,
quantity INTEGER ,
requires_shipping BOOLEAN ,
successfully_fulfilled_quantity INTEGER ,
taxable BOOLEAN ,
total_discount INTEGER ,
product_id INTEGER NOT NULL ,
fulfilment_id INTEGER NOT NULL ,
variant_id INTEGER NOT NULL ,
cart_id INTEGER NOT NULL ,
FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE ,
FOREIGN KEY (fulfilment_id) REFERENCES fulfilments (id) ON DELETE CASCADE ,
FOREIGN KEY (variant_id) REFERENCES variants (id) ON DELETE CASCADE ,
FOREIGN KEY (cart_id) REFERENCES carts (id) ON DELETE CASCADE
);

CREATE TRIGGER line_items_updated_at AFTER UPDATE ON line_items WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE line_items SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE line_item_discounts(
line_item_id INTEGER NOT NULL,
discount_id INTEGER NOT NULL,
FOREIGN KEY (line_item_id) REFERENCES line_items (id) ON DELETE CASCADE ,
FOREIGN KEY (discount_id) REFERENCES discounts (id) ON DELETE CASCADE
);



CREATE TABLE discount_allocations(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
amount INTEGER NOT NULL ,
discount_application_id INTEGER NOT NULL ,
line_item_id INTEGER NOT NULL ,
FOREIGN KEY (discount_application_id) REFERENCES discount_applications (id) ON DELETE CASCADE ,
FOREIGN KEY (line_item_id) REFERENCES line_items (id) ON DELETE CASCADE
);

CREATE TRIGGER discount_allocations_updated_at AFTER UPDATE ON discount_allocations WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE discount_allocations SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE gift_cards(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
balance INTEGER NOT NULL ,
code TEXT ,
enabled BOOLEAN NOT NULL DEFAULT TRUE ,
expires_at DATETIME ,
initial_value INTEGER ,
url TEXT ,
product_id INTEGER NOT NULL ,
customer_id INTEGER NOT NULL ,
currency_id INTEGER ,
FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE ,
FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE ,
FOREIGN KEY (currency_id) REFERENCES currencies (id) ON DELETE SET NULL
);

CREATE TRIGGER gift_cards_updated_at AFTER UPDATE ON gift_cards WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE gift_cards SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE checkouts(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
buyer_accepts_marketing BOOLEAN ,
note TEXT ,
requires_shipping BOOLEAN NOT NULL DEFAULT TRUE ,
shipping_price INTEGER ,
subtotal_price INTEGER ,
tax_price INTEGER ,
total_price INTEGER ,
order_id INTEGER NOT NULL ,
customer_id INTEGER NOT NULL ,
shipping_address_id INTEGER ,
billing_address_id INTEGER ,
shipping_method_id INTEGER ,
transaction_id INTEGER ,
FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE ,
FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE ,
FOREIGN KEY (shipping_address_id) REFERENCES addresses (id) ON DELETE SET NULL ,
FOREIGN KEY (billing_address_id) REFERENCES addresses (id) ON DELETE SET NULL ,
FOREIGN KEY (shipping_method_id) REFERENCES shipping_methods (id) ON DELETE SET NULL ,
FOREIGN KEY (transaction_id) REFERENCES transactions (id) ON DELETE SET NULL
);

CREATE TRIGGER checkouts_updated_at AFTER UPDATE ON checkouts WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE checkouts SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


CREATE TABLE checkout_gift_cards(
checkout_id INTEGER NOT NULL,
gift_card_id INTEGER NOT NULL,
FOREIGN KEY (checkout_id) REFERENCES checkouts (id) ON DELETE CASCADE ,
FOREIGN KEY (gift_card_id) REFERENCES gift_cards (id) ON DELETE CASCADE
);


CREATE TABLE checkout_line_items(
checkout_id INTEGER NOT NULL,
line_item_id INTEGER NOT NULL,
FOREIGN KEY (checkout_id) REFERENCES checkouts (id) ON DELETE CASCADE ,
FOREIGN KEY (line_item_id) REFERENCES line_items (id) ON DELETE CASCADE
);


CREATE TABLE checkout_tax_lines(
checkout_id INTEGER NOT NULL,
tax_line_id INTEGER NOT NULL,
FOREIGN KEY (checkout_id) REFERENCES checkouts (id) ON DELETE CASCADE ,
FOREIGN KEY (tax_line_id) REFERENCES tax_lines (id) ON DELETE CASCADE
);



CREATE TABLE checkout_attributes(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL ,
checkout_id INTEGER NOT NULL ,
FOREIGN KEY (checkout_id) REFERENCES checkouts (id) ON DELETE CASCADE
);

CREATE TRIGGER checkout_attributes_updated_at AFTER UPDATE ON checkout_attributes WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE checkout_attributes SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE order_attributes(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL ,
order_id INTEGER NOT NULL ,
FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE
);

CREATE TRIGGER order_attributes_updated_at AFTER UPDATE ON order_attributes WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE order_attributes SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;




CREATE TABLE customer_attributes(
id INTEGER UNIQUE PRIMARY KEY AUTOINCREMENT NOT NULL ,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL ,
name TEXT NOT NULL ,
value TEXT NOT NULL ,
customer_id INTEGER NOT NULL ,
FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);

CREATE TRIGGER customer_attributes_updated_at AFTER UPDATE ON customer_attributes WHEN old.updated_at < CURRENT_TIMESTAMP BEGIN
    UPDATE customer_attributes SET updated_at = CURRENT_TIMESTAMP WHERE id = old.id;
END;


