describe('A suite is just a function', () => {
  var a = 6

  it('and so is a spec', () => {
    a = a * 9
    expect(a).toEqual(42)
  })
})
