const newInfection = require('./new_infection');

test('newInfection is 16 when 20% of infection rate for 100 population and 20 existing infected population', () => {
  expect(newInfection(0.20,{population:100, infected_population: 20})).toBe(16);
});

test('newInfection is 0 when 20% of infection rate for 100 population and 100 existing infected population', () => {
  expect(newInfection(0.20,{population:100, infected_population: 100})).toBe(0);
});

test('newInfection is 0 when 20% of infection rate for 0 population and 10 existing infected population', () => {
  expect(newInfection(0.20,{population:0, infected_population: 10})).toBe(0);
});

test('newInfection is 0 when -1% of infection rate for 100 population and 10 existing infected population', () => {
  expect(newInfection(-1,{population:100, infected_population: 10})).toBe(0);
});
