class Reader < ActiveRecord::Base
    has_many :subscriptions, dependent: :destroy
    has_many :magazines, through: :subscriptions

    def subscribe(magazine, price)
        Subscription.create(price: price, reader_id: self.id, magazine_id: magazine.id)
    end

    def total_subscription_price
        self.subscriptions.all.map { |sub| sub.price }.sum
    end

    def cancel_subscription(magazine)
        self.subscriptions.find_by(magazine_id: magazine.id).destroy
    end
end