require 'spec_helper'

describe Gnosis::Archive do
  let :assets   do 'spec/gnosis/assets/' end
  let :instance do Gnosis::Archive.new(assets + 'Game.rgss3a') end
  
  describe '.new' do
    context 'given a valid argument' do
      it 'initializes with the given archive' do
        instance = Gnosis::Archive.new(assets + 'Game.rgss3a')
        expect(instance.archive).to eq File.expand_path(assets + 'Game.rgss3a')
      end
      it 'has an appropriate translator assigned' do
        expect(instance.instance_variable_get(:@translator).class).to be \
          Gnosis::Translators::RGSS3A
      end
      it 'builds a hash of file encryption information' do
        expect(instance.files).not_to be_empty
      end
    end
    context 'given an invalid argument' do
      context '(no file)' do
        it 'raises Errno::ENOENT' do
          expect { Gnosis::Archive.new('Bad.rgss3a') }.to \
            raise_error(Errno::ENOENT)
        end
      end
      context '(invalid archive)' do
        it 'raises an InvalidArchiveError' do
          expect { Gnosis::Archive.new(assets + 'Invalid.rgssad') }.to \
            raise_error(Gnosis::Translators::RGSSAD::InvalidArchiveError)
        end
      end
    end
  end
  
  describe '#contents' do
    it 'returns an array of strings representing encrypted files' do
      expect(instance.contents).not_to be_empty
      expect(instance.contents.all? { |f| f.class == String} ).to be true
    end
  end
  
  describe '#size' do
    it 'returns the number of encrypted files' do
      expect(instance.size).not_to be 0
      expect(instance.size).to be instance.contents.size
    end
  end
  
  describe '#decrypt' do
    # TODO: Write this test.
  end
  
  describe '#search' do
    context 'given matching expression' do
      it 'returns an array of matching encrypted files' do
        expect(instance.search(/Actors/)).to eq ['Data/Actors.rvdata2']
      end
    end
    context 'given non-matching expression' do
      it 'returns an empty array' do
        expect(instance.search(/\.png$/)).to be_empty
      end
    end
  end
  
  describe '#glob' do
    context 'given matching shell expression' do
      it 'returns an array of matching encrypted files' do
        expect(instance.glob('**/Actors*')).to eq ['Data/Actors.rvdata2']
      end
    end
    context 'given non-matching shell expression' do
      it 'returns an empty array' do
        expect(instance.glob('**/*.png')).to be_empty
      end
    end
  end
end