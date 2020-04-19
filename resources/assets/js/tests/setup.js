
require('jsdom-global')();

global.testUtils = require( '@vue/test-utils' );
global.createLocalVue = testUtils.createLocalVue;
global.mount = testUtils.mount;
global.shallowMount = testUtils.shallowMount;

global.chai = require('chai');
global.expect = chai.expect;