-- Create table "accounts"
CREATE TABLE "accounts" (
    "id" bigserial PRIMARY KEY,
    "owner" varchar NOT NULL,
    "balance" bigint NOT NULL,
    "currency" varchar NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT now()
);

-- Create table "entries"
CREATE TABLE "entries" (
    "id" bigserial PRIMARY KEY,
    "account_id" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT now()
);

-- Comment on "entries"."amount"
COMMENT ON COLUMN "entries"."amount" IS 'can be positive or negative';

-- Create table "transfers"
CREATE TABLE "transfers" (
    "id" bigserial PRIMARY KEY,
    "from_account_id" bigint NOT NULL,
    "to_account_id" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT now()
);

-- Comment on "transfers"."amount"
COMMENT ON COLUMN "transfers"."amount" IS 'must be a positive number';

-- Create indexes
CREATE INDEX idx_accounts_owner ON "accounts" ("owner");
CREATE INDEX idx_entries_account_id ON "entries" ("account_id");
CREATE INDEX idx_transfers_from_account_id ON "transfers" ("from_account_id");
CREATE INDEX idx_transfers_to_account_id ON "transfers" ("to_account_id");
CREATE INDEX idx_transfers_from_to_account_id ON "transfers" ("from_account_id", "to_account_id");

-- Add foreign keys
ALTER TABLE "entries"
    ADD CONSTRAINT fk_entries_account_id FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers"
    ADD CONSTRAINT fk_transfers_from_account_id FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers"
    ADD CONSTRAINT fk_transfers_to_account_id FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");
