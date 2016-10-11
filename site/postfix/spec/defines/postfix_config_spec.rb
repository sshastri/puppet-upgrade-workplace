require 'spec_helper'

describe 'postfix::config' do
  let (:title) { 'foo' }
  let (:facts) { {
    :lsbdistcodename => 'wheezy',
    :osfamily        => 'Debian',
  } }
  let :pre_condition do
    "class { 'postfix': }"
  end

  context 'when not passing value' do
    it 'should fail' do
      expect {
        is_expected.to contain_augeas("set postfix 'foo'")
      }.to raise_error(Puppet::Error, /value can not be empty/)
    end
  end

  context 'when passing wrong type for value' do
    let (:params) { {
      :value => ['bar'],
    } }
    it 'should fail' do
      expect {
        is_expected.to contain_augeas("set postfix 'foo'")
      }.to raise_error(Puppet::Error, /\["bar"\] is not a string/)
    end
  end

  context 'when passing wrong type for ensure' do
    let (:params) { {
      :value  => 'bar',
      :ensure => ['present'],
    } }
    it 'should fail' do
      expect {
        is_expected.to contain_augeas("set postfix 'foo'")
      }.to raise_error(Puppet::Error, /\["present"\] is not a string/)
    end
  end

  context 'when passing wrong value for ensure' do
    let (:params) { {
      :value  => 'bar',
      :ensure => 'running',
    } }
    it 'should fail' do
      expect {
        is_expected.to contain_augeas("set postfix 'foo'")
      }.to raise_error(Puppet::Error, /must be either 'present', 'absent' or 'blank'/)
    end
  end

  context 'when ensuring presence' do
    let (:params) { {
      :value  => 'bar',
      :ensure => 'present',
    } }

    it { is_expected.to contain_augeas("manage postfix 'foo'").with(
      :incl    => '/etc/postfix/main.cf',
      :lens    => 'Postfix_Main.lns',
      :changes => "set foo 'bar'"
    ) }
  end

  context 'when ensuring absence' do
    let (:params) { {
      :value  => 'bar',
      :ensure => 'absent',
    } }

    it { is_expected.to contain_augeas("manage postfix 'foo'").with(
      :incl    => '/etc/postfix/main.cf',
      :lens    => 'Postfix_Main.lns',
      :changes => "rm foo"
    ) }
  end

  context 'when ensuring blank' do
    let (:params) { {
      :value  => 'bar',
      :ensure => 'blank',
    } }

    it { is_expected.to contain_augeas("manage postfix 'foo'").with(
      :incl    => '/etc/postfix/main.cf',
      :lens    => 'Postfix_Main.lns',
      :changes => "clear foo"
    ) }
  end
end