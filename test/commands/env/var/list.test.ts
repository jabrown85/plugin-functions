import {expect, test} from '@oclif/test'

import vacuum from '../../../helpers/vacuum'

describe('sf env:var:list', () => {
  test
  .stdout()
  .stderr()
  .nock('https://api.heroku.com', api =>
    api
    .get('/apps/my-app/config-vars')
    .reply(200, {
      foo: 'bar',
      baz: 'baq',
    }),
  )
  .command(['env:var:list', '--app', 'my-app'])
  .it('shows a table of config vars', ctx => {
    expect(vacuum(ctx.stdout)).to.contain(vacuum(`
      Key Value
      foo bar
      baz baq
    `))
  })

  test
  .stdout()
  .stderr()
  .nock('https://api.heroku.com', api =>
    api
    .get('/apps/my-app/config-vars')
    .reply(200, {}),
  )
  .command(['env:var:list', '--app', 'my-app'])
  .it('shows a message when there are no config vars', ctx => {
    expect(ctx.stderr).to.include('No config vars found for app my-app')
  })
})
