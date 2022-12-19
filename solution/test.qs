namespace HostPython {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arrays as Array; 

    operation BB84WithoutEve(a : Int[], b : Int[], c : Int[], d : Int[]): String{        
        // create a vector containing 16 qubits in base states |0> and |1> according with array a
        use qubits = Qubit[16];
        for i in 0 .. 15{
            let bit = a[i];
            if bit==1 {
                X(qubits[i]);
            }
        }

        // Alice polarizes qubits using array b
        // b[i]=1 means use Hadamard base
        for i in 0 .. 15{
            let _base = b[i];
            if _base == 1 {
                H(qubits[i]);
            }
        }        


        // Alice send qubits to Bob
        // ...
        // Bob receives qubits


        // Bob polarizes qubits using array c
        // c[i]=1 means use Hadamard base
        for i in 0 .. 15{
            let _base = c[i];
            if _base == 1 {
                H(qubits[i]);
            }
        }


        // Alice and Bob exchange their bases and manteins only the qubit where d[i]==1 (d[i]==1 if b[i]==c[i])
        mutable shared_secret = "";
        for i in 0 .. 15{
            let common_base = d[i];
            if common_base == 1 {
                let misure = M(qubits[i]);
                mutable x = "0";
                if misure == One {
                    set x = "1";
                }
                set shared_secret = shared_secret + x; 
            }

        }   


        // Clear qubits before deallocated them
        for i in 0 .. 15{
            Reset(qubits[i]);
        }
        
        return shared_secret;
    }

    operation BB84WithEve(a : Int[], b : Int[], c : Int[], d : Int[], e : Int[]): String{        
        // Create a vector containing 16 qubits in base states |0> and |1> according with array a
        use qubits = Qubit[16];
        for i in 0 .. 15{
            let bit = a[i];
            if bit==1 {
                X(qubits[i]);
            }
        }

        // Alice polarizes qubits using array b
        // b[i]=1 means use Hadamard base
        for i in 0 .. 15{
            let _base = b[i];
            if _base == 1 {
                H(qubits[i]);
            }
        }        


        // Alice sends qubits to Bob but they are intercepted by Eve


        // Eve polarizes qubits using array d
        // e[i]=1 means use Hadamard base
        for i in 0 .. 15{
            let _base = e[i];
            if _base == 1 {
                H(qubits[i]);
            }
        }


        // Eve send qubits to Bob
        // ...
        // Bob receives qubits


        // Bob polarizes qubits using array c
        // c[i]=1 means use Hadamard base
        for i in 0 .. 15{
            let _base = c[i];
            if _base == 1 {
                H(qubits[i]);
            }
        }


        // Alice and Bob exchange their bases and manteins only the qubit where d[i]==1 (d[i]==1 if b[i]==c[i])
        mutable bob_secret = "";
        for i in 0 .. 15{
            let common_base = d[i];
            if common_base == 1 {
                let misure = M(qubits[i]);
                mutable x = "0";
                if misure == One {
                    set x = "1";
                }
                set bob_secret = bob_secret + x; 
            }
        }   


        // Clear qubits before deallocated them
        for i in 0 .. 15{
            Reset(qubits[i]);
        }
        
        return bob_secret;
    }
}