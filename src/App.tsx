import React, { useState, useEffect } from 'react';
import createModule from './modules_build/main.mjs';

function App() {
  const [test, setTest] = useState<() => number>();

  useEffect(() => {
    createModule().then((Module: any) => {
      console.log('module loaded')
      console.log(Module)
      setTest(() => Module.cwrap("test", "number", [], []));
    }).catch((err: any) => {
      console.log(err);
    })
  });

  if (!test) {
    return <p>Loading</p>;
  }

  const result = test();

  console.log({result});

  return (
    <div className="App">
      Result from C function: { result }
    </div>
  );
}

export default App;
