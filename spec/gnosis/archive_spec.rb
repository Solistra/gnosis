require 'spec_helper'

describe Gnosis::Archive do
  let :assets   do 'spec/gnosis/assets/' end
  let :instance do Gnosis::Archive.new(assets + 'Game.rgss3a') end
  let :binary_data do
    "\u0004\b[\u00100o:\u0015RPG::CommonEvent\n:\r@triggeri\u0000:\n@nameI"  <<
    "\"\u0000\u0006:\u0006ET:\u000F@switch_idi\u0006:\n@list[\u0006o:"       <<
    "\u0016RPG::EventCommand\b:\f@indenti\u0000:\n@codei\u0000:"             <<
    "\u0010@parameters[\u0000:\b@idi\u0006o;\u0000\n;\u0006i\u0000;\aI\""    <<
    "\u0000\u0006;\bT;\ti\u0006;\n[\u0006o;\v\b;\fi\u0000;\ri\u0000;\u000E[" <<
    "\u0000;\u000Fi\ao;\u0000\n;\u0006i\u0000;\aI\"\u0000\u0006;\bT;\ti"     <<
    "\u0006;\n[\u0006o;\v\b;\fi\u0000;\ri\u0000;\u000E[\u0000;\u000Fi\bo;"   <<
    "\u0000\n;\u0006i\u0000;\aI\"\u0000\u0006;\bT;\ti\u0006;\n[\u0006o;"     <<
    "\v\b;\fi\u0000;\ri\u0000;\u000E[\u0000;\u000Fi\to;\u0000\n;\u0006i"     <<
    "\u0000;\aI\"\u0000\u0006;\bT;\ti\u0006;\n[\u0006o;\v\b;\fi\u0000;\ri"   <<
    "\u0000;\u000E[\u0000;\u000Fi\no;\u0000\n;\u0006i\u0000;\aI\"\u0000"     <<
    "\u0006;\bT;\ti\u0006;\n[\u0006o;\v\b;\fi\u0000;\ri\u0000;\u000E["       <<
    "\u0000;\u000Fi\vo;\u0000\n;\u0006i\u0000;\aI\"\u0000\u0006;\bT;\ti"     <<
    "\u0006;\n[\u0006o;\v\b;\fi\u0000;\ri\u0000;\u000E[\u0000;\u000Fi\fo;"   <<
    "\u0000\n;\u0006i\u0000;\aI\"\u0000\u0006;\bT;\ti\u0006;\n[\u0006o;\v\b" <<
    ";\fi\u0000;\ri\u0000;\u000E[\u0000;\u000Fi\ro;\u0000\n;\u0006i\u0000;"  <<
    "\aI\"\u0000\u0006;\bT;\ti\u0006;\n[\u0006o;\v\b;\fi\u0000;\ri\u0000;"   <<
    "\u000E[\u0000;\u000Fi\u000Eo;\u0000\n;\u0006i\u0000;\aI\"\u0000\u0006;" <<
    "\bT;\ti\u0006;\n[\u0006o;\v\b;\fi\u0000;\ri\u0000;\u000E[\u0000;"       <<
    "\u000Fi\u000F"
  end
  
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
    context 'given a valid file' do
      it 'decrypts the file to a binary string' do
        expect(instance.decrypt('Data/CommonEvents.rvdata2')).to eq binary_data
      end
    end
    context 'given an invalid file' do
      it 'raises Errno::ENOENT' do
        expect { instance.decrypt('Invalid') }.to raise_error (Errno::ENOENT)
      end
    end
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
