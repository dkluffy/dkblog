## IPsec Components

### ISAKMP (Internet Security Agreement/Key Management Protocol)

ISAKMP provides a way for two computers to agree on security settings and exchange a security key that they can use to communicate securely. 

### Security Association (SA) 

Security Association (SA) provides all the information needed for two computers to communicate securely. The SA contains a policy agreement that controls which algorithms and key lengths the two machines will use, plus the actual security keys used to securely exchange information.

Each SA consists of values such as destination address, a security parameter index (SPI), the IPSec transforms used for that session, security keys, and additional attributes such as IPSec lifetime. The SAs in each peer have unique SPI values that will be recorded in the Security Parameter Databases of the devices. The Security Parameter Database is set up in dynamic random-access memory (DRAM) and contains parameter values for each SA.

|Describe   | Value |
|-----: | :-----|
|Destination Address | 192.168.2.1|
|Security Paramaeter Index(SPI) | 7a390bc1 |
|IPSec Transform | AH,HMAC-MD5 |
|key             | 7572ca49f7632946 |
|Additional SA attributes (lifetime,etc) | one day or 100MB |

An IPSec transform in Cisco IOS specifies either an AH or an ESP protocol and its corresponding algorithms and mode (transport or tunnel).

| Parameter |Description |
| ----:|:----|
|outbound esp sas: spi: 0x1B781456(460854358)|Security parameter index, which matches inbound SPI for that SA |
|
|transform: esp-des|IPSec transform |
|
|in use settings ={Tunnel, }| IPSec transform mode (tunnel or transport)
|
|slot: 0, conn id: 18, crypto map:mymap| Crypto engine and crypto map information
|
|sa timing: (k/sec) | SA lifetime in KB and seconds
|
|replay detection support: N  |Replay detection either on or off




## IPSEC 过程

### > 1. 定义感兴趣流(ACL)

### >> 2. IKE协商阶段

* **In phase one**, IKE creates an authenticated secure channel between the two IKE peers that is called the IKE Security Association. The **Diffie-Hellman key agreement** is always performed in this phase.

The basic purpose of IKE phase one is to authenticate the IPSec peers and to set up a secure channel between the peers **to enable IKE exchanges**. IKE phase one performs the following functions:

1. Authenticates and protects the identities of the IPSec peers

2. Negotiates a matching IKE SA policy between peers to protect the IKE exchange

3. Performs an authenticated Diffie-Hellman exchange with the end result of having matching shared secret keys

4. Sets up a secure tunnel to negotiate IKE phase two parameters

IKE phase one occurs in two modes:

    * Main mode
    * Aggressive mode


* **In phase two**, IKE negotiates the IPSec security associations and generates the required key material for IPSec. The sender offers one or more transform sets that are used to specify an allowed combination of transforms with their respective settings. The sender also indicates the data flow to which the transform set is to be applied. The sender must offer at least one transform set. The receiver then sends back a single transform set, which indicates the mutually agreed-on transforms and algorithms for this particular IPSec session. **A new Diffie-Hellman agreement** can be done in phase two, or the keys can be derived from the phase one shared secret.

The purpose of IKE phase two is **to negotiate IPSec SAs** to set up the IPSec tunnel. IKE phase two performs the following functions:

1. Negotiates IPSec SA parameters protected by an existing IKE SA

2. Establishes IPSec security associations

3. Periodically renegotiates IPSec SAs to ensure security

4. Optionally performs an additional Diffie-Hellman exchange



```
Perfect Forward Secrecy

If perfect forward secrecy (PFS) is specified in the IPSec policy, a new Diffie-Hellman exchange is performed with each quick mode, providing keying material that has greater entropy (key material life) and thereby greater resistance to cryptographic attacks. Each Diffie-Hellman exchange requires large exponentiations, thereby increasing CPU use and exacting a performance cost.
```


### >>>3. IPSec Encrypted Tunnel

After IKE phase two is complete and quick mode has established IPSec SAs, information is exchanged by an IPSec tunnel. Packets are encrypted and decrypted using the encryption specified in the IPSec SA.

### >>>>4. Tunnel Termination

IPSec SAs terminate through deletion or by timing out. An SA can time out when a specified number of seconds have elapsed or when a specified number of bytes have passed through the tunnel. When the SAs terminate, the keys are also discarded. When subsequent IPSec SAs are needed for a flow, IKE performs a new phase two and, if necessary, a new phase one negotiation. A successful negotiation results in new SAs and new keys. New SAs can be established before the existing SAs expire so that a given flow can continue uninterrupted. 





### The Diffie-Hellman Process

The Diffie-Hellman process is as follows:

 	
     * Step 1	The D-H process starts with each peer generating a large prime integer, p and q. Each peer sends the other its prime integer over the insecure channel. For example, Peer A sends p to Peer B. Each peer then uses the p and q values to generate g, a primitive root of p.
 	
     * Step 2	Each peer generates a private D-H key (Peer A: Xa, Peer B: Xb).
 	
     * Step 3	Each peer generates a public D-H key. The local private key is combined with the prime number p and the primitive root g in each peer to generate a public key: Ya for Peer A and Yb for Peer B. The formula for Peer A is Ya =g^Xa mod p. The formula for Peer B is Yb =g^Xb mod p. The exponentiation is computationally expensive. The ^ character denotes exponentiation (g^Xa is g to the Xa power); mod denotes modulus.
 	
     * Step 4	The public keys Ya and Yb are exchanged in public.
 	
     * Step 5	Each peer generates a shared secret number (ZZ) by combining the public key received from the opposite peer with its own private key. The formula for Peer A is ZZ=(YbXa) mod p. The formula for Peer B is ZZ=(YaXb) mod p. The ZZ values are identical in each peer. Anyone who knows p or g, or the D-H public keys, cannot guess or easily calculate the shared secret value largely because of the difficulty in factoring large prime numbers.
 	
     * Step 6	Shared secret keys are derived from the shared secret number ZZ for use by DES or HMACs.

### Note

```
Each IPSec peer has three keys:

A private key that is kept secret and is never shared—It is used to sign messages.

A public key that is shared—It is used by others to verify a signature.

A shared secret key that is used to encrypt data using an encryption algorithm (DES, MD5, and so on)—The shared secret key is derived from Diffie-Hellman key generation.

```

安全协议：AH协议，ESP协议

连接模式：隧道模式，传输模式

加密方式：对于ESP而言，有DES，3DES，AES-128，AES-192，AES-256或不使用加密算法

验证方式：MD5或SHA-1

IPSec的数据连接看通过安全协议实现对数据连接的保护：AH协议和ESP协议。可以通过其中的一个协议来实现数据的加密和验证，如使用ESP协议，可以使用两个协议一起来实现。AH使用IP协议号51，ESP使用IP协议号50。

AH协议提供了数据完整性服务，数据验证，保护数据回放攻击。AH协议保护整个数据报文，但易变的字段除外，如IP包头中的TTL和TOS字段。