require 'spec_helper'

describe Gnosis::Translators do
  let :assets do 'spec/gnosis/assets/' end
  
  describe '.class_for' do
    context 'given an RGSSAD archive object' do
      it 'returns a Translators::RGSSAD object' do
        instance = Gnosis::Archive.new(assets + 'Game.rgssad')
        expect(subject.class_for(instance).class).to be subject::RGSSAD
      end
    end
    context 'given an RGSS3A archive object' do
      it 'returns a Translators::RGSS3A object' do
        instance = Gnosis::Archive.new(assets + 'Game.rgss3a')
        expect(subject.class_for(instance).class).to be subject::RGSS3A
      end
    end
  end
end