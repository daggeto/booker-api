class Api::SeedsController < ApplicationController
  include RenderResponses

  def create
    factories.map do |factory|
      create_model(factory)
    end

    render_success
  end

  def destroy
    Database::Teardown.new.run

    render_success
  end

  private

  def create_model(factory)
    return create_from_string(factory) if factory.is_a?(String)

    create_from_hash(factory)
  end

  def create_from_string(factory)
    FactoryGirl.create(factory)
  end

  def create_from_hash(factory)
    name, factory_params = factory

    trait = factory_params[:trait].try(:to_sym)

    FactoryGirl.create(name.to_sym, trait, factory_params[:attributes])
  end

  def factories
    @factories ||= params[:factories] || []
  end
end
