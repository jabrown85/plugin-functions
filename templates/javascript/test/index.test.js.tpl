const { expect } = require('chai');
const { createSandbox } = require('sinon');

const execute = require('../index');

/**
 * {{fnNameCased}} unit tests.
 */

describe('Unit Tests', () => {

    let sandbox;
    let mockContext;
    let mockLogger;
    let accounts;

    beforeEach(() => {
        mockContext = {
            org: {
                dataApi: { query: () => {} }
            },
            logger: { info: () => {} }
        };

        mockLogger = mockContext.logger;
        sandbox = createSandbox();

        sandbox.stub(mockContext.org.dataApi, "query");
        sandbox.stub(mockLogger, "info");

        accounts = {
            'totalSize': 3,
            'done': true,
            'records': [
                {
                    'attributes':
                        {'type':'Account','url':'/services/data/v48.0/sobjects/Account/001xx000003GYNjAAO'},
                        'Name':'Global Media'
                },
                {
                    'attributes':
                        {'type':'Account','url':'/services/data/v48.0/sobjects/Account/001xx000003GYNkAAO'},
                        'Name':'Acme'
                },
                {
                    'attributes':
                    {'type':'Account','url':'/services/data/v48.0/sobjects/Account/001xx000003GYNlAAO'},
                    'Name':'salesforce.com'
                }
            ]
        };

        mockContext.org.dataApi.query.callsFake(() => {
            return Promise.resolve(accounts);
        });
    });

    afterEach(() => {
        sandbox.restore();
    });

    it('Invoke {{fnNameCased}}', async () => {
        const results = await execute({ data: {} }, mockContext, mockLogger);

        expect(mockContext.org.dataApi.query.callCount).to.be.eql(1);
        expect(mockLogger.info.callCount).to.be.eql(2);
        expect(results).to.be.not.undefined;
        expect(results).has.property('totalSize');
        expect(results.totalSize).to.be.eql(accounts.totalSize);
    });
});