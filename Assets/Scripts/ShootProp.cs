using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShootProp : MonoBehaviour
{
    [SerializeField]private GameObject BulletPrefab;
    [SerializeField]private float shootForce;
   
    // Update is called once per frame
    void Update()
    {
        if(Input.GetKey(KeyCode.Space)){
            GameObject SpawnedBulletPrefab = Instantiate(BulletPrefab, transform.position + transform.forward, Quaternion.identity);
            SpawnedBulletPrefab.GetComponent<Rigidbody>().velocity = transform.forward * shootForce;
        }
    }
}
