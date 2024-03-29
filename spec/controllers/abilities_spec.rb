require 'spec_helper'
require "cancan/matchers"
require "factory_girl"

describe "User" do
  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is an admin" do
      let(:user) { FactoryGirl.create(:user, admin: true) }

      it{ should be_able_to(:manage, :all) }
    end

    shared_examples_for "unprivilidged" do |user_types = []|

      # FIXME: Detect inherticance of types, rather than use array
      (ModelsHelper.all_models - user_types).each do |model|
          model = model.constantize
          it { should_not be_able_to(:destroy, model) }
          it { should_not be_able_to(:edit, model) }

          unless model == User or model == Ticket
            it { should_not be_able_to(:create, model) }
          end
      end

      it { should_not be_able_to(:read, Staff) }
      it { should_not be_able_to(:read, FactoryGirl.build(:user, admin: true)) }
      it { should_not be_able_to(:read, Staff) }
      it { should_not be_able_to(:index, WattballPlayer) }
    end

    context "when is a staff member" do
      let(:user) { FactoryGirl.create(:staff).user }

      #it_behaves_like "unprivilidged", [Staff.to_s]

      it { should_not be_able_to(:manage, Staff) }
      it { should be_able_to :create, Team }
      it { should be_able_to :create, User }
      it { should be_able_to :read, :all }
    end

    context "when is a team manager" do
      let(:user) { FactoryGirl.create(:team).user }

      it_behaves_like "unprivilidged", [Team.to_s]

      it { should be_able_to(:self_maintain, user.team) }
      it { should_not be_able_to(:manage, Team.all - [user.team]) }

      # Shouldn't be able to read EVERYTHING
      it { should be_able_to(:read, :all) }
    end

    context "when is  hurdle player" do
      let(:user) { FactoryGirl.create(:hurdle_player).user }

      it{ should be_able_to(:self_maintain, HurdlePlayer) }
      it { should_not be_able_to(:modify, HurdlePlayer.all - [user.hurdle_player])  }
      it_behaves_like "unprivilidged", ["HurdlePlayer"]
    end

    context "when is an wattball player" do
      let(:user) { FactoryGirl.create(:wattball_player).user }

      it{ should be_able_to(:self_maintain, WattballPlayer) }
      it { should_not be_able_to(:modify, WattballPlayer.all - [user.wattball_player])  }

      it_behaves_like "unprivilidged", ["WattballPlayer"]
    end

    context "when is an authed user" do
      let(:user) { FactoryGirl.create(:user) }

      it { should be_able_to(:read, :all) }
      it { should be_able_to(:edit, user) }

      # Cannot edit any other users
      it {should_not be_able_to(:edit, User.all - [user])}
      it { should be_able_to(:create, Ticket) }

      it_behaves_like "unprivilidged", [Ticket.to_s, WattballPlayer.to_s, HurdlePlayer.to_s]
    end

    context "when is a guest" do
      (ModelsHelper.all_models - ["Staff", "Admin", "Ticket"]).each do |model|
          model = model.constantize

          # NOTE: Tests that buying tickets not allowed
          it{ should be_able_to(:read, model) }
          it{ should_not be_able_to(:edit, model)  }
          if (model != User) 
              # Should be able to create a user
              it { should_not be_able_to(:manage, model) }
          end
      end
      it { should_not be_able_to(:read, Staff)  }
      it { should_not be_able_to(:manage, Ticket)  }
    end

  end
end
