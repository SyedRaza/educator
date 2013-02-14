class CreateDeactivateAccounts < ActiveRecord::Migration
  def self.up
    create_table :deactivate_accounts do |t|
      t.string :reasons

      t.timestamps
    end
    DeactivateAccount.create(:reasons=>'I get too many emails, invitations, and requests.')
    DeactivateAccount.create(:reasons=>'I have another account.')
    DeactivateAccount.create(:reasons=>'I\'ll be back.')
    DeactivateAccount.create(:reasons=>'My account was hacked.')
    DeactivateAccount.create(:reasons=>'Others')
  end

  def self.down
    drop_table :deactivate_accounts
  end
end
