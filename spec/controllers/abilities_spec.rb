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

    context "when is a team manager" do
      let(:user) { FactoryGirl.create(:team).User }

      it { should be_able_to(:manage, Team) }
      it { should be_able_to(:read, :all) }

      (ModelsHelper.all_models - [:team.capitalize.to_s]).each do |model|
          model = model.constantize
          it { should_not be_able_to(:destroy, model) }
          it { should_not be_able_to(:edit, model) }
      end
    end

    context "when is  hurdle player" do
      let(:user) { FactoryGirl.create(:hurdle_player).user }

      it{ should be_able_to(:modify, HurdlePlayer) }
      it{ should be_able_to(:new_hurdle_player, HurdlePlayer) }
    end

    context "when is an wattball player" do
      let(:user) { FactoryGirl.create(:wattball_player).user }

      it{ should be_able_to(:modify, WattballPlayer) }
      it{ should be_able_to(:new_wattball_player, WattballPlayer) }
    end

    context "when is an authed user" do
      let(:user) { FactoryGirl.create(:user) }

      it{ should be_able_to(:read, :all) }
      it {should be_able_to(:create, Ticket)}
    end

    context "when is a guest" do
      (ModelsHelper.all_models).each do |model|
          model = model.constantize

          # NOTE: Tests that buying tickets not allows
          # TODO: Print out what is being not allowed
          it{ should be_able_to(:read, model) }
          it{ should be_able_to(:read, model) }
          it{ should_not be_able_to(:edit, model) }
      end
    end

  end
end
