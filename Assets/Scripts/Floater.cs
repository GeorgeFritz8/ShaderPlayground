using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Floater : MonoBehaviour
{
    [SerializeField]private Rigidbody rb;
    [SerializeField]private float seaLevel;
    [SerializeField]private float depthBeforeSubmerged = 1f;
    [SerializeField]private float displacementAmount = 3f;
    [SerializeField]private int floaters;
    [SerializeField]private int waterDrag;
    [SerializeField]private int waterAngularDrag;

    private void FixedUpdate() {
        rb.AddForceAtPosition(Physics.gravity / floaters, transform.position, ForceMode.Acceleration);
        if(transform.position.y < seaLevel){
            float displacementMultiplier = Mathf.Clamp01(-transform.position.y / depthBeforeSubmerged) * displacementAmount;
            rb.AddForceAtPosition(new Vector3(0f, Mathf.Abs(Physics.gravity.y) * displacementMultiplier, 0f), transform.position, ForceMode.Acceleration);
            rb.AddForce(displacementMultiplier * -rb.velocity * waterDrag * Time.fixedDeltaTime, ForceMode.VelocityChange);
            rb.AddTorque(displacementMultiplier * -rb.angularVelocity * waterAngularDrag * Time.fixedDeltaTime, ForceMode.VelocityChange);

        }
    }
}
