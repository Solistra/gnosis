require 'spec_helper'

describe Gnosis::Translators::Key do
  describe '.new' do
    context 'given no argument' do
      it 'initializes with key state 0xDEADCAFE' do
        expect(subject.class.new.key).to eq 0xDEADCAFE
      end
    end
    context 'given an argument' do
      it 'initializes with the given key state' do
        expect(subject.class.new(0xFFFFFFFF).key).to eq 0xFFFFFFFF
      end
    end
  end
  
  describe '.advance' do
    it 'appropriately mutates the key state' do
      instance = subject.class.new
      expect(instance.advance).to eq 381717749
    end
  end
  
  describe '.current' do
    it 'returns the current key state' do
      instance = subject.class.new
      instance.advance
      expect(instance.current).to eq 381717749
    end
  end
end