import React from 'react';
import { IREPLACEProps } from './interfaces';
import useREPLACE from './hooks/useREPLACE';
import styles from './styles.module.scss';

const REPLACE: React.FC<IREPLACEProps> = () => {
    const {} = useREPLACE();
    return <div>Hello world!</div>
}

export default REPLACE;
