using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoatMovement : MonoBehaviour
{
    private Rigidbody rb;
    [SerializeField]private float moveSpeed;
    [SerializeField]private float rotSpeed;

    // Start is called before the first frame update
    void Start()
    {
        rb = gameObject.GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKey(KeyCode.W)){
            rb.AddForce(rb.transform.forward * moveSpeed, ForceMode.Acceleration);
        }
        if(Input.GetKey(KeyCode.A)){
            transform.Rotate(new Vector3(0, -rotSpeed, 0f) * Time.deltaTime);
        }
        if(Input.GetKey(KeyCode.D)){
            transform.Rotate(new Vector3(0, rotSpeed, 0f) * Time.deltaTime);
        }
    }
}
