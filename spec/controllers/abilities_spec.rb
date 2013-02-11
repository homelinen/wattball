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
      end
    end

    context "when is a staff member" do
      let(:user) { FactoryGirl.create(:staff).user }

      #it_behaves_like "unprivilidged", [Staff.to_s]

      it { should_not be_able_to(:manage, Staff) }
      it { should be_able_to(:create, Team) }
      it { should be_able_to(:read, :all) }
    end

    context "when is a team manager" do
      let(:user) { FactoryGirl.create(:team).User }

      it_behaves_like "unprivilidged", [Team.to_s]

      it { should be_able_to(:manage, Team) }
      it { should be_able_to(:read, :all) }
    end

    shared_context "is athlete", :a => :b do
      # Gets the descendants of athlets and add Athlete onto the array
      @athlete_types = 
        Athlete.descendants.map { |klass| klass.to_s  }.push Athlete.to_s
    end

    context "when is  hurdle player" do
      let(:user) { FactoryGirl.create(:hurdle_player).user }
      include_context "is athlete"

      it{ should be_able_to(:modify, HurdlePlayer) }
      it{ should be_able_to(:new_hurdle_player, HurdlePlayer) }

      it_behaves_like "unprivilidged", @athlete_types
    end

    context "when is an wattball player" do
      let(:user) { FactoryGirl.create(:wattball_player).user }
      include_context "is athlete"

      it{ should be_able_to(:modify, WattballPlayer) }
      it{ should be_able_to(:new_wattball_player, WattballPlayer) }

      it_behaves_like "unprivilidged", @athlete_types
    end

    context "when is an authed user" do
      let(:user) { FactoryGirl.create(:user) }

      it{ should be_able_to(:read, :all) }
      it {should be_able_to(:create, Ticket)}

      it_behaves_like "unprivilidged"
    end

    context "when is a guest" do
      (ModelsHelper.all_models).each do |model|
          model = model.constantize

          # NOTE: Tests that buying tickets not allowed
          it{ should be_able_to(:read, model) }
          it{ should be_able_to(:read, model) }
          it{ should_not be_able_to(:edit, model) }
      end
    end

  end
end
