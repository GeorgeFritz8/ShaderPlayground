using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionCall : MonoBehaviour
{
    public Material Material;

    void Update()
    {
        Material.SetVector("_Pos", transform.position);
    }
}
